Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8564D0A76
	for <lists+linux-arch@lfdr.de>; Mon,  7 Mar 2022 23:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiCGWEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Mar 2022 17:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiCGWEq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2022 17:04:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8C13A199
        for <linux-arch@vger.kernel.org>; Mon,  7 Mar 2022 14:03:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C3EB60E86
        for <linux-arch@vger.kernel.org>; Mon,  7 Mar 2022 22:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5A5C340F4;
        Mon,  7 Mar 2022 22:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690630;
        bh=ZfB+qqW0LGpCiciJCSs/OO+Ysvkzg3uawsoNh3RpyhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGvNERzJtRRihZMnpHcs/jVf3YXkxnM4pgobcMW6f/lacBNuWKLt6vO7S90GyqRnL
         X6T65Ll7kyLIxcEf6oCenDkBeJ4h3z8S8RRFSEH7PHXCrsdD3cInGmA4/6Qb/W4vxE
         hKytU11uozyRtnLLJuOeIyCJSuZAQHOhnHC6UsoXWJyz3GHkc61sIF1+1COXLxogBW
         OPYwHSz/HaddTII4E3LTPEKADUOGnV+2SnybDKTf8HWP8wM3Y7aR0Jp45jgJtD9E2D
         O38I8VNfB6HepRIXUM7TY8uE+WFYfHlIRz8GX4Y083O1H+ctH+7tOJq9CbpG4zob5Q
         j6PnviJ+2afjQ==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 0/2] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon,  7 Mar 2022 22:03:27 +0000
Message-Id: <164669030645.141062.12667484591752564518.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220228130606.1070960-1-broonie@kernel.org>
References: <20220228130606.1070960-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Feb 2022 13:06:04 +0000, Mark Brown wrote:
> Deployments of BTI on arm64 have run into issues interacting with
> systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> linked executables the kernel will only handle architecture specific
> properties like BTI for the interpreter, the expectation is that the
> interpreter will then handle any properties on the main executable.
> For BTI this means remapping the executable segments PROT_EXEC |
> PROT_BTI.
> 
> [...]

Applied to arm64 (for-next/bti), thanks!

[1/2] elf: Allow architectures to parse properties on the main executable
      https://git.kernel.org/arm64/c/825b99a491ec
[2/2] arm64: Enable BTI for main executable as well as the interpreter
      https://git.kernel.org/arm64/c/ddc35eb71d63

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
