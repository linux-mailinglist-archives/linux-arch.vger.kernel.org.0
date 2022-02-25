Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871C64C49BB
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 16:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiBYPzH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 10:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242446AbiBYPzG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 10:55:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DDB1DC99B
        for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2022 07:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 509A1619B0
        for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2022 15:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053A5C340E7;
        Fri, 25 Feb 2022 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804472;
        bh=G9/p6FmtXs1vTqclaOI0yL/rc424g+Z+Ra+Ekrn8y6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dD0UUg4JFU24BWhW26WmuhmtDzNNdUF4ozx1KGKjxZtoBaqiGCBwrYWzbWC1Cl/5N
         i9bwbGCDFKEgdr5P4dM4GtxDATiX5wN4B/FvkaIjrmtlUnXtwN3e+SySCa5d//lqIe
         PLAic+HDjq8PV+XCOqRFUdF20UPo055MWOXtH2YTiKFDb/RWU+UuL1LXXcuVY5nSBc
         a3dyW52Zf1Vrp6KBtmuu1Ar8MdIRKziZtvNCbrMZ/kcJ5XmdzfuwIqqnHdT6qjip/P
         OT6woo2LoUkDqiNZe6Boa4hWauae9jkJqB1p9hknOgN64HMjOqYo8xxeMwtU3OkF+j
         J/vdJAcWm5Jlw==
Date:   Fri, 25 Feb 2022 15:54:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220225155426.GB20310@willie-the-truck>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
 <Ygz9YX3jBY0MpepU@arm.com>
 <20220225135350.GA19698@willie-the-truck>
 <Yhjxr3+U2qd6b3yK@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhjxr3+U2qd6b3yK@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 25, 2022 at 03:11:43PM +0000, Mark Brown wrote:
> On Fri, Feb 25, 2022 at 01:53:51PM +0000, Will Deacon wrote:
> 
> > I still think this new behaviour should be opt-in, so adding a sysctl for
> > that would be my preference if we proceed with this approach.
> 
> I'm happy to have a sysctl but I'd rather it be opt out rather than opt
> in since it seems better to default to enabling the security feature
> when there is a strong expectation that it would seem better to enable
> it by default sine it's not expected to be disruptive and the sysctl is
> more of a "what if there's a problem" thing.

I think new behaviour has to be opt-in, so that if somebody takes a new
kernel then we can guarantee it's not going to break them. Systemd can
enable this unconditionally if it wants to.

Will
