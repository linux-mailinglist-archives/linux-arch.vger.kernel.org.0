Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9490061FE34
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 20:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiKGTJD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 14:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiKGTI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 14:08:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364D426AE5;
        Mon,  7 Nov 2022 11:08:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5059B8166E;
        Mon,  7 Nov 2022 19:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55E3C433D7;
        Mon,  7 Nov 2022 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667848133;
        bh=H6DAwa6JNO0axAZdhmPXEJbdF+PQ0zDnqwU6lJz87/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=US/qy1s6PTFXgo99vU436mUOS3mXhD3GK4d+HcMLIshUTl3P52p72purEdSbsoFta
         eYOA16xsqMVwxCkl13PqtYsmp7GjPX6DHSZKEGcTv5/pszsegDY2ThHFTLamZBzK9z
         Wyw7hTIQDT2Bw1y60r990cXwU/ox6Ft4C1rU15dFE5Q2eynvPVYxphvqJA9C+rW+qY
         b1PXv7T6/+D3R2PRcaEGCYXXdTGEUPemKOF7lXsWz1BEifymuYvN29uScAPtCRsW8a
         HIIkfSilhBI4/wDokH0/eQ8oEjhRd8bkzx3cE2PKgmzeHIpTo11JbnpScsST7CojWu
         /JAmitOU2VrPw==
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] arm64: remove special treatment for the link order of head.o
Date:   Mon,  7 Nov 2022 19:08:36 +0000
Message-Id: <166783716442.32724.935158280857906499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221012233500.156764-1-masahiroy@kernel.org>
References: <20221012233500.156764-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 13 Oct 2022 08:35:00 +0900, Masahiro Yamada wrote:
> In the previous discussion (see the Link tag), Ard pointed out that
> arm/arm64/kernel/head.o does not need any special treatment - the only
> piece that must appear right at the start of the binary image is the
> image header which is emitted into .head.text.
> 
> The linker script does the right thing to do. The build system does
> not need to manipulate the link order of head.o.
> 
> [...]

Applied to arm64 (for-next/kbuild), thanks!

[1/1] arm64: remove special treatment for the link order of head.o
      https://git.kernel.org/arm64/c/994b7ac1697b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
