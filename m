Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A88CDAA1
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2019 05:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfJGDZZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 23:25:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45073 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfJGDZY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 23:25:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so11965227ljb.12
        for <linux-arch@vger.kernel.org>; Sun, 06 Oct 2019 20:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=lnRCQZ6E1mSxSM8DhK/bYoz8RlQC/6+QfFeh+yCRFwE=;
        b=YQQolMBHIte2V0HiBVg8aEvgqYwmylgdV3wVZMFmocDedWoJK5Va9R9cvxxqfuGnYW
         OWZHAv8ap4UNhidle/+0H2UZsCCPczebgHmbTH2rJLx4BZrDwpC3Xmi/lZSygYDZFYF1
         ZHYco8rtMcIkxJz14j/LnaxQuXNDREYKsvi38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lnRCQZ6E1mSxSM8DhK/bYoz8RlQC/6+QfFeh+yCRFwE=;
        b=FwKghG37Ogk2ypFG/oYG5lqGQ6A3haAWWzREoXiPmkMwJtsXel+3FclW3kJiL3oB5g
         k71JBRnm1YCxjYd6R2VZvP5VdaIJyr16F5YTidChv0rZjqvl3ih1E5zDYSKTm/DOzLGY
         Scs6YGhJZpOgCpSIRfyJOxTw3kcBNB9Bj5KGEkZUL58yC5Js1O20zS1ain4S5ns6Ngmu
         oao3pKXIDG/xtGuc9F26xcNJnUIx5aerN38YXyz8Viy1qNmjFjLbct0rOpiVg8xLufR4
         kOelBHD55Ssp/9We0SpdwMrq7x8zJMUT6RUx3O8DX+ekaI+mm/Dtmm0DbxfKbfK2NMQ6
         wtYw==
X-Gm-Message-State: APjAAAUXQXJ6yC/i3Axk4tOVzUCzmNRMSB5EYRDIvV98whFonoag0Bwu
        5FRIPi3Ch+uoZrbUPXE/hb8qURotUSg=
X-Google-Smtp-Source: APXvYqxi4dy8yDIYgT1p37nCKr1tR2vgh6pNci6sL8eci+cxwAmkkauVugRNs43Du9F85vihpeLd8w==
X-Received: by 2002:a2e:720e:: with SMTP id n14mr17217642ljc.63.1570418722584;
        Sun, 06 Oct 2019 20:25:22 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p27sm2614297lfo.95.2019.10.06.20.25.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:25:21 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u28so8149491lfc.5
        for <linux-arch@vger.kernel.org>; Sun, 06 Oct 2019 20:25:21 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr15317089lfc.106.1570418721367;
 Sun, 06 Oct 2019 20:25:21 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 20:25:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGqnJc6obUGSAsP8YCFEb_ZhD2Zfz-aWxdS_E_R_1xVw@mail.gmail.com>
Message-ID: <CAHk-=wiGqnJc6obUGSAsP8YCFEb_ZhD2Zfz-aWxdS_E_R_1xVw@mail.gmail.com>
Subject: Unaligned user pointer issues..
To:     linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

So Guenther Roeck reported that my fancy readdir() user access
optimization broke alpha and sparc64 boot for him.

(It really improves things on x86 - I swear! The cost of telling the
CPU over and over again to "please allow user space accesses" is
horrendously high, so doing the whole "user_access_begin()/end() just
_once_ per dirent is a big deal).

It turns out that it's broken on at least alpha because it does that
filename copy to user space by hand, and the "linux_filldir64"
structure is set up so that the name part is basically never aligned.
So when it does the word copies, it does them as unaligned
"put_user()" invocations.

I'll fix it, never fear, since it's clearly a horrible performance
pessimization on architectures that don't deal unaligned accesses
well.

However, at least on alpha, it's not just that unaligned user accesses
were slow, they didn't actually _work_.

And that's a problem.

Because they are easy to trigger from user space even without any new
readdir code.

This trivial program causes a kernel oops on alpha:

  #define _GNU_SOURCE
  #include <unistd.h>
  #include <sys/mman.h>

  int main(int argc, char **argv)
  {
        void *mymap;
        uid_t *bad_ptr = (void *) 0x01;

        /* Create unpopulated memory area */
        mymap = mmap(NULL, 16384,
                PROT_READ | PROT_WRITE,
                MAP_PRIVATE | MAP_ANONYMOUS,
                -1, 0);

        /* Unaligned uidpointer in that memory area */
        bad_ptr = mymap+1;

        /* Make the kernel do put_user() on it */
        return getresuid(bad_ptr, bad_ptr+1, bad_ptr+2);
  }

because getresuid() does "put_user()" on that unaligned pointer, and
it looks like something goes badly sideways when it first takes the
unaligned trap, and then the unaligned trap handler gets an exception
on the emulation code.

I'm not sure what the alpha bug is (I looked at the code just long
enough to see that it _tries_ to do the exception handling), but the
fact that apparently I broke at least sparc64 too makes me suspect
that other architectures have this issue too.

So hey, can I ask architecture maintainers to try the above trivial
program and see how it works (or doesn't)?

On alpha, when Guenther tried my silly test-program, he reported:

  # ./mmtest
  Unable to handle kernel paging request at virtual address 0000000000000004
  mmtest(75): Oops -1
  pc = [<0000000000000004>]  ra = [<fffffc0000311584>]  ps = 0000    Not tainted
  pc is at 0x4
  ra is at entSys+0xa4/0xc0
  v0 = fffffffffffffff2  t0 = 0000000000000000  t1 = 0000000000000000
  ...

which is not what is supposed to happen ;)

            Linus
