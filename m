Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1DC608C1E
	for <lists+linux-arch@lfdr.de>; Sat, 22 Oct 2022 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJVLBy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 22 Oct 2022 07:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJVLBT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Oct 2022 07:01:19 -0400
X-Greylist: delayed 1783 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Oct 2022 03:19:43 PDT
Received: from mx08-006a4e02.pphosted.com (mx08-006a4e02.pphosted.com [143.55.148.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9AB5A834;
        Sat, 22 Oct 2022 03:19:41 -0700 (PDT)
Received: from pps.filterd (m0316698.ppops.net [127.0.0.1])
        by mx08-006a4e02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29M5tZmh007584;
        Sat, 22 Oct 2022 08:06:30 +0200
Received: from mta-out01.sim.rediris.es (mta-out01.sim.rediris.es [130.206.24.43])
        by mx08-006a4e02.pphosted.com (PPS) with ESMTPS id 3kbp6ce53y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Oct 2022 08:06:30 +0200
Received: from mta-out01.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPS id 5FE293008AAC;
        Sat, 22 Oct 2022 08:06:29 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTP id 4C10E3008C30;
        Sat, 22 Oct 2022 08:06:29 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-out01.sim.rediris.es
Received: from mta-out01.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out01.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5h559gs9VuxO; Sat, 22 Oct 2022 08:06:29 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPA id 3D3823008AAC;
        Sat, 22 Oct 2022 08:06:27 +0200 (CEST)
Date:   Sat, 22 Oct 2022 08:06:21 +0200
From:   Gabriel Paubert <paubert@iram.es>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <Y1OIXdh3vWOMUlQK@lt-gp.iram.es>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <Y1Elx+e5VLCTfyXi@lt-gp.iram.es>
 <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
Content-Transfer-Encoding: 8BIT
X-Proofpoint-GUID: QhCUmQhypiY_jIEz4kLssNrn_gVxl2_Z
X-Proofpoint-ORIG-GUID: QhCUmQhypiY_jIEz4kLssNrn_gVxl2_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbounddefault_notspam policy=outbounddefault score=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210220038
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 21, 2022 at 03:46:01PM -0700, Linus Torvalds wrote:
> On Thu, Oct 20, 2022 at 3:41 AM Gabriel Paubert <paubert@iram.es> wrote:
> >
> > I must miss something, the strcmp man page says:
> >
> > "The comparison is done using unsigned characters."
> 
> You're not missing anything, I just hadn't looked at strcmp() in forever.
> 
> Yeah, strcmp clearly doesn't care about the signedness of 'char', and
> arguably an unsigned char argument makes more sense considering the
> semantics of the funmction.
> 
> > But it's not for this that I wrote this message. Has anybody considered
> > using transparent unions?
> 
> I don't love the transparent union-as-argument syntax, but you're
> right, that would fix the warning.

I'm not in love with the syntax either.

> 
> Except it then doesn't actually *work* very well.
> 
> Try this:
> 
>         #include <sys/types.h>
> 
>         #if USE_UNION
>         typedef union {
>                 const char *a;
>                 const signed char *b;
>                 const unsigned char *c;
>         } conststring_arg __attribute__ ((__transparent_union__));
>         size_t strlen(conststring_arg);
>         #else
>         size_t strlen(const char *);
>         #endif
> 
>         int test(char *a, unsigned char *b)
>         {
>                 return strlen(a)+strlen(b);
>         }
> 
>         int test2(void)
>         {
>                 return strlen("hello");
>         }
> 
> and now compile it both ways with
> 
>         gcc -DUSE_UNION -Wall -O2 -S t.c
>         gcc -Wall -O2 -S t.c
> 

Ok, I´ve just tried it, except that I had something slightly different in
mind, but perhaps should have been clearer in my first post.

I have change your code to the following:


#include <sys/types.h>

#if USE_UNION
typedef union {
	const char *a;
	const signed char *b;
	const unsigned char *c;
} conststring_arg __attribute__ ((__transparent_union__));
static inline size_t strlen(conststring_arg p)
{
	return __builtin_strlen(p.a);
}
#else
size_t strlen(const char *);
#endif

int test(char *a, unsigned char *b)
{
	return strlen(a)+strlen(b);
}

int test2(void)
{
	return strlen("hello");
}

> and notice how yes, the "-DUSE_UNION" one silences the warning about
> using 'unsigned char *' for strlen. So it seems to work fine.
> 
> But then look at the code it generates for 'test2()" in the two cases.

Now test2 looks properly optimized.

This is a bit exploiting a compiler loophole, it calls an external
function which has been defined with the same name!

Depending on how you look at it, it's either disgusting or clever.

I don´t have clang installed, so I don't know whether it would swallow
this code or react with a strong allergy.

	Gabriel
> 
> The transparent union version actually generates a function call to an
> external 'strlen()' function.
> 
> The regular version uses the compiler builtin, and just compiles
> test2() to return the constant value 5.
> 
> So playing games with anonymous union arguments ends up also disabling
> all the compiler optimizations we do want, becaue apparently gcc then
> decides "ok, I'm not going to warn about you declaring this
> differently, but I'm also not going to use the regular one because you
> declared it differently".
> 
> This, btw, is also the reason why we don't use --freestanding in the
> kernel. We do want the basic <string.h> things to just DTRT.
> 
> For the sockaddr_in games, the above isn't an issue. For strlen() and
> friends, it very much is.
> 
>                        Linus


 

