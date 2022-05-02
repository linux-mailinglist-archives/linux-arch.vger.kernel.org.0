Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183AE516EB5
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiEBLUy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiEBLUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 07:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4EBC17;
        Mon,  2 May 2022 04:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B15761283;
        Mon,  2 May 2022 11:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F0FC385AF;
        Mon,  2 May 2022 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651490242;
        bh=GkYFnxMu4KkGdGXijx6fJDyeOKqT+h0EwHNgiNnnBK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fv//++GuSKeLCwJG0gn1sKviE01NtlO/W4IDmpeVyOgPI8GvzHiEiMWb1PdtbHTFp
         CJg2HCtZ11W3S0M3m1DEq5XVRiCh70TjR3BwYc6cBIr31Oezrmj0eZol7eV4KGdVgl
         ewNSwer5OWRd0E0Gu4BButn62mMXobZjd06FBoUsEH4lPRuc/LdN4rJfMTuIRQOBM9
         5luOlQ1PSPJVCCpDDZ222wzRKLbMn4jAlKaMt98znzeB5jQX3nPV8kBZ11d52Up+kB
         orSqqAZrWGjtw4C+kpIR2wbOB7esOjOvlhGYh5yOYpyu2cZ2qd/yDdlE1k0/mJzsLz
         Vl9VBugZXaV+g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH 1/4] efi: stub: add prototypes for load_image and start_image
Date:   Mon,  2 May 2022 13:17:07 +0200
Message-Id: <20220502111710.4093567-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502111710.4093567-1-ardb@kernel.org>
References: <20220502111710.4093567-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; h=from:subject; bh=GkYFnxMu4KkGdGXijx6fJDyeOKqT+h0EwHNgiNnnBK8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBib72xIBginCS26tW5lPV0Am+u4nhJKhJfv1OdqDDX FHO8zTCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYm+9sQAKCRDDTyI5ktmPJL/kC/ 9aJ94BcWsWtSXHbvFgQFseIjMD/xVQlRiq0W0pgfRdZ74ZlP+i0B5JnOu0/2AhGBePPFgMJmsExJET RyGDtQ/S8mLOU3l1px97P09uJCStb6XI8Cwfw/f65W7v2KOEKyZbm+r8vcF0USzj1mddWj6C31gtus uYnjSkRAIYQZcucrEl6O9MTEHofL9qGxVtMtGeFabmbYg83sj8io0PzgutsIE5MZA504XPRIk71HAN 6lzSk82PAJ1EeUVAMBLcEdom6LQ9RXq+4Tf5A7dyw7l4ggMu5kgnEg5cVSnYekw6dgC6db4fjgmu6Q zPTKB2iYApDh3lfR5EOVzPDg+IT/GXvzzZORTU1sv/PTAOsWPEe7OAPF6JBqYfDP1A64KpkNMmXqnt NG5/1mYLJOKHhf2uXpqChn5IrDnLHsS/i7RuWHjZW29KLfsoLNKOmwh5RvEhxnhFYgvHrnBEi4csSi Zd7PwT4pyylClq8BwWZXtVV1z1PD1KvR/jszGgILmF5Qo=
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

Define the correct prototypes for the load_image and start_image boot
service pointers so we can call them from the EFI zboot code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a0477afaa55f..af51ccc01ce2 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -254,8 +254,12 @@ union efi_boot_services {
 							    efi_handle_t *);
 		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
 								     void *);
-		void *load_image;
-		void *start_image;
+		efi_status_t (__efiapi *load_image)(bool, efi_handle_t,
+						    efi_device_path_protocol_t *,
+						    void *, unsigned long,
+						    efi_handle_t *);
+		efi_status_t (__efiapi *start_image)(efi_handle_t, unsigned long *,
+						     efi_char16_t **);
 		efi_status_t __noreturn (__efiapi *exit)(efi_handle_t,
 							 efi_status_t,
 							 unsigned long,
-- 
2.30.2

