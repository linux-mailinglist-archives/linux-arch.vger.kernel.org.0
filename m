Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB93FCDCCF
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2019 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfJGIFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Oct 2019 04:05:32 -0400
Received: from smtp-4.orcon.net.nz ([60.234.4.59]:52097 "EHLO
        smtp-4.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGIFc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Oct 2019 04:05:32 -0400
X-Greylist: delayed 1052 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 04:05:30 EDT
Received: from [121.99.228.40] (port=39233 helo=tower)
        by smtp-4.orcon.net.nz with esmtpa (Exim 4.90_1)
        (envelope-from <mcree@orcon.net.nz>)
        id 1iHNkL-0005hT-Hg; Mon, 07 Oct 2019 20:47:57 +1300
Date:   Mon, 7 Oct 2019 20:47:52 +1300
From:   Michael Cree <mcree@orcon.net.nz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org
Subject: Re: Unaligned user pointer issues..
Message-ID: <20191007074752.GA3441@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org
References: <CAHk-=wiGqnJc6obUGSAsP8YCFEb_ZhD2Zfz-aWxdS_E_R_1xVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGqnJc6obUGSAsP8YCFEb_ZhD2Zfz-aWxdS_E_R_1xVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 06, 2019 at 08:25:05PM -0700, Linus Torvalds wrote:
> So Guenther Roeck reported that my fancy readdir() user access
> optimization broke alpha and sparc64 boot for him.
> 
> (It really improves things on x86 - I swear! The cost of telling the
> CPU over and over again to "please allow user space accesses" is
> horrendously high, so doing the whole "user_access_begin()/end() just
> _once_ per dirent is a big deal).
> 
> It turns out that it's broken on at least alpha because it does that
> filename copy to user space by hand, and the "linux_filldir64"
> structure is set up so that the name part is basically never aligned.
> So when it does the word copies, it does them as unaligned
> "put_user()" invocations.
> 
> I'll fix it, never fear, since it's clearly a horrible performance
> pessimization on architectures that don't deal unaligned accesses
> well.
> 
> However, at least on alpha, it's not just that unaligned user accesses
> were slow, they didn't actually _work_.
> 
> And that's a problem.
> 
> Because they are easy to trigger from user space even without any new
> readdir code.
> 
> This trivial program causes a kernel oops on alpha:
> 
>   #define _GNU_SOURCE
>   #include <unistd.h>
>   #include <sys/mman.h>
> 
>   int main(int argc, char **argv)
>   {
>         void *mymap;
>         uid_t *bad_ptr = (void *) 0x01;
> 
>         /* Create unpopulated memory area */
>         mymap = mmap(NULL, 16384,
>                 PROT_READ | PROT_WRITE,
>                 MAP_PRIVATE | MAP_ANONYMOUS,
>                 -1, 0);
> 
>         /* Unaligned uidpointer in that memory area */
>         bad_ptr = mymap+1;
> 
>         /* Make the kernel do put_user() on it */
>         return getresuid(bad_ptr, bad_ptr+1, bad_ptr+2);
>   }
> 
> because getresuid() does "put_user()" on that unaligned pointer, and
> it looks like something goes badly sideways when it first takes the
> unaligned trap, and then the unaligned trap handler gets an exception
> on the emulation code.
> 
> I'm not sure what the alpha bug is (I looked at the code just long
> enough to see that it _tries_ to do the exception handling), but the
> fact that apparently I broke at least sparc64 too makes me suspect
> that other architectures have this issue too.
> 
> So hey, can I ask architecture maintainers to try the above trivial
> program and see how it works (or doesn't)?
> 
> On alpha, when Guenther tried my silly test-program, he reported:
> 
>   # ./mmtest
>   Unable to handle kernel paging request at virtual address 0000000000000004
>   mmtest(75): Oops -1
>   pc = [<0000000000000004>]  ra = [<fffffc0000311584>]  ps = 0000    Not tainted
>   pc is at 0x4
>   ra is at entSys+0xa4/0xc0
>   v0 = fffffffffffffff2  t0 = 0000000000000000  t1 = 0000000000000000
>   ...
> 
> which is not what is supposed to happen ;)

Testing the above on an XP1000 running 5.4.0-rc2 built for Alpha
DP264 reveals no problems.  No Oops reported.  Unaligned access
count goes up by three in /proc/cpuinfo as expected.  But
interestingly the kernel unaligned access count is quite high
(14000 or so) on this kernel after boot whereas with the 5.2.y
kernel I was recently running it was zero.

Cheers,
Michael.
