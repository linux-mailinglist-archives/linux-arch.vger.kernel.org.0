Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B2509C78
	for <lists+linux-arch@lfdr.de>; Thu, 21 Apr 2022 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356019AbiDUJhE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbiDUJhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 05:37:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E83F1DA7A
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 02:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD72D6179B
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 09:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3957BC385A1;
        Thu, 21 Apr 2022 09:34:11 +0000 (UTC)
Date:   Thu, 21 Apr 2022 10:34:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, hjl.tools@gmail.com,
        libc-alpha@sourceware.org, szabolcs.nagy@arm.com,
        yu-cheng.yu@intel.com, ebiederm@xmission.com,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YmElD5AghKP4Zgdd@arm.com>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck>
 <Yl/ZCvPB2Qx98+OG@arm.com>
 <Yl/1KertC3/UtwR4@sirena.org.uk>
 <d6c4e1ca-b485-48e5-ede9-d346bd0af599@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c4e1ca-b485-48e5-ede9-d346bd0af599@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 20, 2022 at 08:39:14AM -0500, Jeremy Linton wrote:
> On 4/20/22 06:57, Mark Brown wrote:
> > On Wed, Apr 20, 2022 at 10:57:30AM +0100, Catalin Marinas wrote:
> > > On Wed, Apr 20, 2022 at 10:36:13AM +0100, Will Deacon wrote:
> > > > Kees, please can you drop this series while Catalin's alternative solution
> > > > is under discussion (his Reviewed-by preceded the other patches)?
> > 
> > > > https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com
> > 
> > > > Both series expose new behaviours to userspace and we don't need both.
[...]
> > > Arguably, the two approaches are complementary but the way this series
> > > turned out is for the BTI on main executable to be default off. I have a
> > > worry that the feature won't get used, so we just carry unnecessary code
> > > in the kernel. Jeremy also found this approach less than ideal:
> > 
> > > https://lore.kernel.org/r/59fc8a58-5013-606b-f544-8277cda18e50@arm.com
> > 
> > I'm not sure there was a fundamental concern with the approach there but
> > rather some pushback on the instance on turning it off by default.
> 
> Right, this one seems to have the smallest impact on systemd as it exists
> today.

It had a bigger impact on glibc which had to rework the dynamic library
mapping to use munmap/mmap() instead of an mprotect() (though that's
already done). I think glibc still prefers the mprotect() approach for
dynamic libraries.

> I would have expected the default to be on, because IMHO this set
> corrects what at first glance just looks like a small oversight.

This was a design decision at the time, maybe not the best but it gives
us some flexibility (and we haven't thought of MDWE).

> I find the ABI questions a bit theoretical, given that this should
> only affect environments that don't exist outside of labs/development
> orgs at this point (aka systemd services on HW that implements BTI).

The worry is not what breaks now but rather what happens when today's
distros will eventually be deployed on large-scale BTI-capable hardware.
It's a very small risk but non-zero. The idea is that if we come across
some weird problem, a fixed-up dynamic loader could avoid enabling BTI
on a per-process basis without the need to do this at the system level.

Personally I'm fine with this risk. Will is not and I respect his
position, hence I started the other thread to come up with a MDWE
alternative.

> The other approach works, and if the systemd folks are on board with it also
> should solve the underlying problem, but it creates a bit of a compatibility
> problem with existing containers/etc that might exist today (although
> running systemd/services in a container is itself a discussion).
> 
> So, frankly, I don't see why they aren't complementary.

They are complementary, though if we change the MDWE approach, there's
less of a need for this patchset.

-- 
Catalin
