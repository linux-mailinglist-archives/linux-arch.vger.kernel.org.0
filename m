Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE1606041
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJTMfV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJTMfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 08:35:20 -0400
X-Greylist: delayed 1027 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Oct 2022 05:35:15 PDT
Received: from mx07-006a4e02.pphosted.com (mx07-006a4e02.pphosted.com [143.55.146.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F7102519;
        Thu, 20 Oct 2022 05:35:12 -0700 (PDT)
Received: from pps.filterd (m0316691.ppops.net [127.0.0.1])
        by mx07-006a4e02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KAEBRI009544;
        Thu, 20 Oct 2022 12:41:23 +0200
Received: from mta-out02.sim.rediris.es (mta-out02.sim.rediris.es [130.206.24.44])
        by mx07-006a4e02.pphosted.com (PPS) with ESMTPS id 3kap06ju7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 12:41:22 +0200
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPS id 7B32FC02C85;
        Thu, 20 Oct 2022 12:41:20 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTP id 8FEF2C7E875;
        Thu, 20 Oct 2022 12:41:19 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-out02.sim.rediris.es
Received: from mta-out02.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out02.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c-vdy7asy2cd; Thu, 20 Oct 2022 12:41:19 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPA id 76767C02C85;
        Thu, 20 Oct 2022 12:41:16 +0200 (CEST)
Date:   Thu, 20 Oct 2022 12:41:11 +0200
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
Message-ID: <Y1Elx+e5VLCTfyXi@lt-gp.iram.es>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: sXg_k5kmM2AAHVXJm2rB98z9Q7h1JG_G
X-Proofpoint-GUID: sXg_k5kmM2AAHVXJm2rB98z9Q7h1JG_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbounddefault_notspam policy=outbounddefault score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 mlxlogscore=829 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200063
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 11:11:16AM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 10:45 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > When I did this more than a decade ago there indeed was a LOT of noise,
> > mostly caused by dubious code.
> 
> It really happens with explicitly *not* dubious code.

Indeed.

[snip]
> The "-Wpointer-sign" thing could probably be fairly easily improved,
> by just recognizing that things like 'strlen()' and friends do not
> care about the sign of 'char', and neither does a 'strcmp()' that only
> checks for equality (but if you check the *sign* of strcmp, it does
> matter).

I must miss something, the strcmp man page says:

"The comparison is done using unsigned characters."

But it's not for this that I wrote this message. Has anybody considered
using transparent unions?

They've been heavily used by userland networking code to pass pointer to
sockets, and they work reasonably well in that context IMHO.

So a very wild idea might to make string handling functions accept
transparent union of "char *" and "unsigned char *".

I've not even tried to write any code in this direction, so it's very
likely that this idea won't fly, and it clearly does not solve all
problems. It also probably needs a lot of surgery to avoid clashing with
GCC builtins and unfortunately lose some optimizations.

	Gabriel

> 
> It's been some time since I last tried it, but at least from memory,
> it really was mostly the standard C string functions that caused
> almost all problems.  Your *own* functions you can just make sure the
> signedness is right, but it's really really annoying when you try to
> be careful about the byte signs, and the compiler starts complaining
> just because you want to use the bog-standard 'strlen()' function.
> 
> And no, something like 'ustrlen()' with a hidden cast is just noise
> for a warning that really shouldn't exist.
> 
> So some way to say 'this function really doesn't care about the sign
> of this pointer' (and having the compiler know that for the string
> functions it already knows about anyway) would probably make almost
> all problems with -Wsign-warning go away.
> 
> Put another way: 'char *' is so fundamental and inherent in C, that
> you can't just warn when people use it in contexts where sign really
> doesn't matter.
> 
>                  Linus
 

