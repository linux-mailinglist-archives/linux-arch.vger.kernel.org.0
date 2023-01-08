Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF4E661532
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jan 2023 13:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAHMue (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Jan 2023 07:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjAHMud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Jan 2023 07:50:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77492;
        Sun,  8 Jan 2023 04:50:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NqcPJ65Trz4xwl;
        Sun,  8 Jan 2023 23:50:28 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, schwab@linux-m68k.org,
        linux-arch@vger.kernel.org, nathan@kernel.org
In-Reply-To: <20230105132349.384666-1-mpe@ellerman.id.au>
References: <20230105132349.384666-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT
Message-Id: <167318219560.903173.5982638830598181633.b4-ty@ellerman.id.au>
Date:   Sun, 08 Jan 2023 23:49:55 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 6 Jan 2023 00:23:47 +1100, Michael Ellerman wrote:
> The powerpc linker script explicitly includes .exit.text, because
> otherwise the link fails due to references from __bug_table and
> __ex_table. The code is freed (discarded) at runtime along with
> .init.text and data.
> 
> That has worked in the past despite powerpc not defining
> RUNTIME_DISCARD_EXIT because DISCARDS appears late in the powerpc linker
> script (line 410), and the explicit inclusion of .exit.text
> earlier (line 280) supersedes the discard.
> 
> [...]

Applied to powerpc/fixes.

[1/3] powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT
      https://git.kernel.org/powerpc/c/4b9880dbf3bdba3a7c56445137c3d0e30aaa0a40
[2/3] powerpc/vmlinux.lds: Don't discard .rela* for relocatable builds
      https://git.kernel.org/powerpc/c/07b050f9290ee012a407a0f64151db902a1520f5
[3/3] powerpc/vmlinux.lds: Don't discard .comment
      https://git.kernel.org/powerpc/c/be5f95c8779e19779dd81927c8574fec5aaba36c

cheers
