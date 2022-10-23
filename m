Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D1609618
	for <lists+linux-arch@lfdr.de>; Sun, 23 Oct 2022 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiJWUY5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 23 Oct 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiJWUYz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 23 Oct 2022 16:24:55 -0400
Received: from mx07-006a4e02.pphosted.com (mx07-006a4e02.pphosted.com [143.55.146.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E4813CD4;
        Sun, 23 Oct 2022 13:24:44 -0700 (PDT)
Received: from pps.filterd (m0316692.ppops.net [127.0.0.1])
        by m0316692.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29NKKQJ6017297;
        Sun, 23 Oct 2022 22:24:06 +0200
Received: from mta-out01.sim.rediris.es (mta-out01.sim.rediris.es [130.206.24.43])
        by m0316692.ppops.net (PPS) with ESMTPS id 3kcu9mc2sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Oct 2022 22:24:06 +0200
Received: from mta-out01.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPS id 26DDA3000047;
        Sun, 23 Oct 2022 22:24:05 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTP id E22013197C11;
        Sun, 23 Oct 2022 22:24:04 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-out01.sim.rediris.es
Received: from mta-out01.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out01.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AvB5T1Imovv1; Sun, 23 Oct 2022 22:24:04 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPA id B07C23000047;
        Sun, 23 Oct 2022 22:24:01 +0200 (CEST)
Date:   Sun, 23 Oct 2022 22:23:56 +0200
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
Message-ID: <Y1Wi29MuYlCRTKfH@lt-gp.iram.es>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <Y1Elx+e5VLCTfyXi@lt-gp.iram.es>
 <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
 <Y1OIXdh3vWOMUlQK@lt-gp.iram.es>
 <CAHk-=wgaeTa9nAeJ8DP1cBWrs8fZvJ7k1-L8-kjxEOxpLf+XNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaeTa9nAeJ8DP1cBWrs8fZvJ7k1-L8-kjxEOxpLf+XNA@mail.gmail.com>
Content-Transfer-Encoding: 8BIT
X-Proofpoint-ORIG-GUID: zgBEguqV2sx207ySGJtcCtxIxSPFqKi5
X-Proofpoint-GUID: zgBEguqV2sx207ySGJtcCtxIxSPFqKi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbounddefault_notspam policy=outbounddefault score=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=769 spamscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210230130
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 22, 2022 at 11:16:33AM -0700, Linus Torvalds wrote:
> On Fri, Oct 21, 2022 at 11:06 PM Gabriel Paubert <paubert@iram.es> wrote:
> >
> > Ok, I´ve just tried it, except that I had something slightly different in
> > mind, but perhaps should have been clearer in my first post.
> >
> > I have change your code to the following:
> 
> I actually tested that, but using a slightly different version, and my
> non-union test case ended up like
> 
>    size_t strlen(const char *p)
>   {
>         return __builtin_strlen(p);
>   }
> 
> and then gcc actually complains about
> 
>     warning: infinite recursion detected
> 
> and I (incorrectly) thought this was unworkable. But your version
> seems to work fine.

Incidentally, it also gives exactly the same code with -ffreestanding.

> 
> So yeah, for the kernel I think we could do something like this. It's
> ugly, but it gets rid of the crazy warning.

Not as ugly as casts IMO, and it's localized in a few header files.

However, it does not solve the problem of assigning a constant string to
an u8 *; I've no idea on how to fix that.

> 
> Practically speaking this might be a bit painful, because we've got
> several different variations of this all due to all the things like
> our debugging versions (see <linux/fortify-string.h> for example), so
> some of our code is this crazy jungle of "with this config, use this
> wrapper".

I've just had a look at that code, and I don't want to touch it with a
10 foot pole. If someone else to get his hands dirty... 

	Gabriel

> 
> But if somebody wants to deal with the '-Wpointer-sign' warnings,
> there does seem to be a way out. Maybe with another set of helper
> macros, creating those odd __transparent_union__ wrappers might even
> end up reasonable.
> 
> It's not like we don't have crazy macros for function wrappers
> elsewhere (the SYSCALL macros come to mind - shudder). The macros
> themselves may be a nasty horror, but when done right the _use_ point
> of said macros can be nice and clean.
> 
>                   Linus
 

