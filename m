Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3064B7732
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiBOSfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 13:35:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbiBOSfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 13:35:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53AFDAAEF
        for <linux-arch@vger.kernel.org>; Tue, 15 Feb 2022 10:35:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4B9616AE
        for <linux-arch@vger.kernel.org>; Tue, 15 Feb 2022 18:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A31DC340EB;
        Tue, 15 Feb 2022 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950101;
        bh=5HkG5cK/Ph09OfutxonuDoT40ZCAlg7WRiUNI6GPzLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKmMnVynZOgZFWY+GrXgC5GUKDczd79UImVuQHFwqfnOrJiBb/l4ntKUZdcivpZUZ
         uEWvmNJvz1BLiJkgf2JUIrfVXSN00SVq/8ltpQJFvCM53/BYuJJFt4pYHL96f+/RrG
         AgOrUIyB/TPdl6eDqCnhbYMB6Caz782wyzyxf88Iyj+BHWUv4npkuFWTQ1pOSNM8M+
         MEiZZVpQwdb5xKwQD+pEWS7s+OyhbhsYqErtNcCoPRxtHvA6sO5Yriexz/5WslLVJm
         lwWBXi5qws2vGluXrEJ3qOhJ2aUz8sPDg8x3q9bygTatgeWzFdx3v4zbRpQaNxU3wP
         g95TbU7ZbbsLA==
Date:   Tue, 15 Feb 2022 18:34:56 +0000
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
Message-ID: <20220215183456.GB9026@willie-the-truck>
References: <20220124150704.2559523-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124150704.2559523-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 03:07:00PM +0000, Mark Brown wrote:
> Deployments of BTI on arm64 have run into issues interacting with
> systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> linked executables the kernel will only handle architecture specific
> properties like BTI for the interpreter, the expectation is that the
> interpreter will then handle any properties on the main executable.
> For BTI this means remapping the executable segments PROT_EXEC |
> PROT_BTI.
> 
> This interacts poorly with MemoryDenyWriteExecute since that is
> implemented using a seccomp filter which prevents setting PROT_EXEC on
> already mapped memory and lacks the context to be able to detect that
> memory is already mapped with PROT_EXEC.  This series resolves this by
> handling the BTI property for both the interpreter and the main
> executable.

This appears to be a user-visible change which cannot be detected or
disabled from userspace. If there is code out there which does not work
when BTI is enabled, won't that now explode when the kernel enables it?
How are we supposed to handle such a regression?

Will
