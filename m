Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E60516EB3
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiEBLUy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiEBLUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 07:20:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3715DEAC;
        Mon,  2 May 2022 04:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 116D5B8162D;
        Mon,  2 May 2022 11:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB30C385AC;
        Mon,  2 May 2022 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651490239;
        bh=/NUGOhWVSEuqyq23XVD3Tqg47orwt4l6Jhq/TPU9BYs=;
        h=From:To:Cc:Subject:Date:From;
        b=s8GzRiAx3ohTo0JmFglIRoqgMhwjzEZrFgaFnMGwZ6X3B19v0mO7JLKDowlWt8Iu/
         ShsWW1gmZ+J6ZVV0f9PfKKFhtGFkM8VGlHh/aDGxz8n5wSkrXKaQeP5iOx4/8TmlKL
         KFGK0JOP/Uhw7842DPD+eYQSgTM7xuvXaISXhHfBcwHMuZKrN0R6APmplcO8GCCQgP
         XGPuwc8/Ud9UDLRHi6OlhUuOMSZoSoqUnCeKAfg/f/+BaDcK1LdNPZwNoPG9SiSeFW
         XVI7uP9kIbjY6+TwJ59KDm9w/SAL0YwOigep+mmZ6j02exptSADq7vk9qDYg9sL+de
         Z9Esh1fJaFNuQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH 0/4] efi: implement generic compressed boot support
Date:   Mon,  2 May 2022 13:17:06 +0200
Message-Id: <20220502111710.4093567-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499; h=from:subject; bh=/NUGOhWVSEuqyq23XVD3Tqg47orwt4l6Jhq/TPU9BYs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBib72vxg9bgwfCuQEpVE6kPYxa6WuQSQ9xtMrKmy+1 zUG2VquJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYm+9rwAKCRDDTyI5ktmPJIr6DA CElnNxZviHMO0HsKLTzSZDVvyK2QpBqyaiT/5xNjhoJ0jw/1iF9kdhqrsGEtScx9qFgmeJLt72ZVCb eTiE8Qnj8G5woCUYf3adufjXJiVaIMV9jQE5PrdJI9u9GH0KwmjNdwhQNDl8U7AzWNzrChVjhI7Dvv pc8VbbdCU2vLeBPXsYyUAleR1kvQTROuMhnqb5NQZXnecOjSdDZtN5PRbzO53hkNQCjwlChbEjroau UwcojOaKuBVOADj4GlxIKO+awmDJwdQVeL215+3TAHHd7wXBzatPptGYkW/8TWWl4fg9jUgq6RYj55 yqmhikOBBxblhVZDY6GL1UwtLpb9plptINU97h6PHaZjkASSFVRIzImYMtoVoafo9usNEvRqV3eZqC Zqf9EQMEArJsfrOc2kyc9Xt2LQTMntLEpojXNiM/ycmRwJdufTVZWfPGfXqmm9wjOJ/907jxphiKzj Gf2QHKP5nRU8Z9Z/pgenZgrDUcaVYXJXjiX6/j5nhmG0E=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Relatively modern architectures such as arm64 or RISC-V don't implement
a self-decompressing kernel, and leave it up to the bootloader to
decompress the compressed image before executing it. Not doing so makes
sense for bare metal boot, as it essentially duplicates a lot of fiddly
preparation work to create a 1:1 mapping and set up the C runtime, and
to discover or infer where DRAM lives from device trees or other
firmware tables.

For EFI boot, the situation is a bit different: the EFI entrypoint is
called with a 1:1 mapping covering all of DRAM already active, and with
a stack, a heap, a memory map and boot services to load and start
images. This means it is rather trivial to implement a
self-decompressing wrapper for EFI boot in a generic manner, and reuse
it across architectures that implement EFI boot.

The downside is that two signatures are needed for UEFI secure boot: one
for the decompressed image and one for the compressed images, as they
are both PE/COFF EFI executables that are launched by the firmware. But
that is actually the whole point, so it is simply the other side of the
same coin.

Related discussion going on here:
https://lore.kernel.org/all/20220430090518.3127980-22-chenhuacai@loongson.cn/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>

Ard Biesheuvel (4):
  efi: stub: add prototypes for load_image and start_image
  efi: stub: split off printk() routines
  efi: stub: implement generic EFI zboot
  arm64: efi: enable generic EFI compressed boot

 arch/arm64/Makefile                            |   5 +
 arch/arm64/boot/Makefile                       |  17 ++-
 drivers/firmware/efi/Kconfig                   |   6 +
 drivers/firmware/efi/libstub/Makefile          |   4 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 141 -----------------
 drivers/firmware/efi/libstub/efistub.h         |   8 +-
 drivers/firmware/efi/libstub/printk.c          | 158 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot-header.S    |  88 +++++++++++
 drivers/firmware/efi/libstub/zboot.c           |  86 +++++++++++
 drivers/firmware/efi/libstub/zboot.lds         |  44 ++++++
 10 files changed, 412 insertions(+), 145 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/printk.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
 create mode 100644 drivers/firmware/efi/libstub/zboot.c
 create mode 100644 drivers/firmware/efi/libstub/zboot.lds

-- 
2.30.2

