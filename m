Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64FE9C393
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2019 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfHYNYN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Aug 2019 09:24:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37914 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfHYNYM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Aug 2019 09:24:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id o70so9836599pfg.5;
        Sun, 25 Aug 2019 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJqaaN3fFlNFQlgDnqMXC9K3Wn4iCAubnxsjfvsinrg=;
        b=aUENNOnTkc6UvqkiK35jB6tUYGyM3TlDKalbikNLu59Q1ula/2Ga+nHGf1vvpR+24f
         T70el8qOEE8Js9Hv0fCRSaf5/h+Ee+TtWHSTiEw/On20HMF+MGhSLdILu6xb3OeqJGD0
         v4SmlD696FiPnCEHt7nKgdfXV1KReF2EKfgmKkWRVQfggOFucpUyrpP+wMwIsThgKuG7
         9NM1+C4jBZf8JCU7fWzbrufyWAcqSoTjSFCzRqJJlnpLBGW64qDjwQWVPtThqjdBHjhF
         ROVV4uLMS8CM3JTQuM9NCBt4uahyzBDMBlGy7sMu2kDvOmHPNzLGh8R/8dGZi/QL0bga
         3SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJqaaN3fFlNFQlgDnqMXC9K3Wn4iCAubnxsjfvsinrg=;
        b=ExtHtGD803Ji++GZMCO0YqPWsXOQgKITbVM6eRmmGS0Vx3ZFBPOeOyczowHwrtQf8U
         wkic8lomaKvfB5q5K43gX9YPKTfO8+ZMj9clh6vqUhyB3gvu5ZNnhCcoLhFJV/rokOWq
         v+3hg6LZSdWwrToXL+IzQrSMV6uNtuw6oZKASG+7jSZMGO944L22mvfeOW/Bxfq0sGrD
         6yUMNHCWw0ew1f9MX6T9uncCKZ0SqLCOaShzLnKy9cbsBM7RvSSuX82Fz+XOkbtTVLBP
         wJESHuqEWuxHJqSMfKm+HD7pjFTWExEOGVtRZFn4tdi5ISOXTeNsaHBMV1vW2lBQQFim
         SUPQ==
X-Gm-Message-State: APjAAAX4sIJxslkObJmbrmHrAasca4YlGzaLLi68NEJchU2R6USaT7bS
        ut3WYcAS6KXeYYiDax+eH1c=
X-Google-Smtp-Source: APXvYqxBB4sMg5D7Mm+ptiLy9D8i4zanUHATTOCxqDzRbVRsUB905N5kg4h4DAYSv8z2SCDUUgkMWA==
X-Received: by 2002:a17:90a:ec12:: with SMTP id l18mr14467542pjy.6.1566739451635;
        Sun, 25 Aug 2019 06:24:11 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:24:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 03/11] asm-generic: add generic dwarf definition
Date:   Sun, 25 Aug 2019 21:23:22 +0800
Message-Id: <20190825132330.5015-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add generic DWARF constant definitions. We will use it later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/asm-generic/dwarf.h | 199 ++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100644 include/asm-generic/dwarf.h

diff --git a/include/asm-generic/dwarf.h b/include/asm-generic/dwarf.h
new file mode 100644
index 000000000000..c705633c2a8f
--- /dev/null
+++ b/include/asm-generic/dwarf.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Architecture independent definitions of DWARF.
+ *
+ * Copyright (C) 2019 Changbin Du <changbin.du@gmail.com>
+ */
+#ifndef __ASM_GENERIC_DWARF_H
+#define __ASM_GENERIC_DWARF_H
+
+/*
+ * DWARF expression operations
+ */
+#define DW_OP_addr		0x03
+#define DW_OP_deref		0x06
+#define DW_OP_const1u		0x08
+#define DW_OP_const1s		0x09
+#define DW_OP_const2u		0x0a
+#define DW_OP_const2s		0x0b
+#define DW_OP_const4u		0x0c
+#define DW_OP_const4s		0x0d
+#define DW_OP_const8u		0x0e
+#define DW_OP_const8s		0x0f
+#define DW_OP_constu		0x10
+#define DW_OP_consts		0x11
+#define DW_OP_dup		0x12
+#define DW_OP_drop		0x13
+#define DW_OP_over		0x14
+#define DW_OP_pick		0x15
+#define DW_OP_swap		0x16
+#define DW_OP_rot		0x17
+#define DW_OP_xderef		0x18
+#define DW_OP_abs		0x19
+#define DW_OP_and		0x1a
+#define DW_OP_div		0x1b
+#define DW_OP_minus		0x1c
+#define DW_OP_mod		0x1d
+#define DW_OP_mul		0x1e
+#define DW_OP_neg		0x1f
+#define DW_OP_not		0x20
+#define DW_OP_or		0x21
+#define DW_OP_plus		0x22
+#define DW_OP_plus_uconst	0x23
+#define DW_OP_shl		0x24
+#define DW_OP_shr		0x25
+#define DW_OP_shra		0x26
+#define DW_OP_xor		0x27
+#define DW_OP_skip		0x2f
+#define DW_OP_bra		0x28
+#define DW_OP_eq		0x29
+#define DW_OP_ge		0x2a
+#define DW_OP_gt		0x2b
+#define DW_OP_le		0x2c
+#define DW_OP_lt		0x2d
+#define DW_OP_ne		0x2e
+#define DW_OP_lit0		0x30
+#define DW_OP_lit1		0x31
+#define DW_OP_lit2		0x32
+#define DW_OP_lit3		0x33
+#define DW_OP_lit4		0x34
+#define DW_OP_lit5		0x35
+#define DW_OP_lit6		0x36
+#define DW_OP_lit7		0x37
+#define DW_OP_lit8		0x38
+#define DW_OP_lit9		0x39
+#define DW_OP_lit10		0x3a
+#define DW_OP_lit11		0x3b
+#define DW_OP_lit12		0x3c
+#define DW_OP_lit13		0x3d
+#define DW_OP_lit14		0x3e
+#define DW_OP_lit15		0x3f
+#define DW_OP_lit16		0x40
+#define DW_OP_lit17		0x41
+#define DW_OP_lit18		0x42
+#define DW_OP_lit19		0x43
+#define DW_OP_lit20		0x44
+#define DW_OP_lit21		0x45
+#define DW_OP_lit22		0x46
+#define DW_OP_lit23		0x47
+#define DW_OP_lit24		0x48
+#define DW_OP_lit25		0x49
+#define DW_OP_lit26		0x4a
+#define DW_OP_lit27		0x4b
+#define DW_OP_lit28		0x4c
+#define DW_OP_lit29		0x4d
+#define DW_OP_lit30		0x4e
+#define DW_OP_lit31		0x4f
+#define DW_OP_reg0		0x50
+#define DW_OP_reg1		0x51
+#define DW_OP_reg2		0x52
+#define DW_OP_reg3		0x53
+#define DW_OP_reg4		0x54
+#define DW_OP_reg5		0x55
+#define DW_OP_reg6		0x56
+#define DW_OP_reg7		0x57
+#define DW_OP_reg8		0x58
+#define DW_OP_reg9		0x59
+#define DW_OP_reg10		0x5a
+#define DW_OP_reg11		0x5b
+#define DW_OP_reg12		0x5c
+#define DW_OP_reg13		0x5d
+#define DW_OP_reg14		0x5e
+#define DW_OP_reg15		0x5f
+#define DW_OP_reg16		0x60
+#define DW_OP_reg17		0x61
+#define DW_OP_reg18		0x62
+#define DW_OP_reg19		0x63
+#define DW_OP_reg20		0x64
+#define DW_OP_reg21		0x65
+#define DW_OP_reg22		0x66
+#define DW_OP_reg23		0x67
+#define DW_OP_reg24		0x68
+#define DW_OP_reg25		0x69
+#define DW_OP_reg26		0x6a
+#define DW_OP_reg27		0x6b
+#define DW_OP_reg28		0x6c
+#define DW_OP_reg29		0x6d
+#define DW_OP_reg30		0x6e
+#define DW_OP_reg31		0x6f
+#define DW_OP_breg0		0x70
+#define DW_OP_breg1		0x71
+#define DW_OP_breg2		0x72
+#define DW_OP_breg3		0x73
+#define DW_OP_breg4		0x74
+#define DW_OP_breg5		0x75
+#define DW_OP_breg6		0x76
+#define DW_OP_breg7		0x77
+#define DW_OP_breg8		0x78
+#define DW_OP_breg9		0x79
+#define DW_OP_breg10		0x7a
+#define DW_OP_breg11		0x7b
+#define DW_OP_breg12		0x7c
+#define DW_OP_breg13		0x7d
+#define DW_OP_breg14		0x7e
+#define DW_OP_breg15		0x7f
+#define DW_OP_breg16		0x80
+#define DW_OP_breg17		0x81
+#define DW_OP_breg18		0x82
+#define DW_OP_breg19		0x83
+#define DW_OP_breg20		0x84
+#define DW_OP_breg21		0x85
+#define DW_OP_breg22		0x86
+#define DW_OP_breg23		0x87
+#define DW_OP_breg24		0x88
+#define DW_OP_breg25		0x89
+#define DW_OP_breg26		0x8a
+#define DW_OP_breg27		0x8b
+#define DW_OP_breg28		0x8c
+#define DW_OP_breg29		0x8d
+#define DW_OP_breg30		0x8e
+#define DW_OP_breg31		0x8f
+#define DW_OP_regx		0x90
+#define DW_OP_fbreg		0x91
+#define DW_OP_bregx		0x92
+#define DW_OP_piece		0x93
+#define DW_OP_deref_size	0x94
+#define DW_OP_xderef_size	0x95
+#define DW_OP_nop		0x96
+#define DW_OP_push_object_address	0x97
+#define DW_OP_call2		0x98
+#define DW_OP_call4		0x99
+#define DW_OP_call_ref		0x9a
+#define DW_OP_form_tls_address	0x9b
+#define DW_OP_call_frame_cfa	0x9c
+#define DW_OP_bit_piece		0x9d
+#define DW_OP_implicit_value	0x9e
+#define DW_OP_stack_value	0x9f
+#define DW_OP_implicit_pointer	0xa0
+#define DW_OP_addrx		0xa1
+#define DW_OP_constx		0xa2
+#define DW_OP_entry_value	0xa3
+#define DW_OP_const_type	0xa4
+#define DW_OP_regval_type	0xa5
+#define DW_OP_deref_type	0xa6
+#define DW_OP_xderef_type	0xa7
+#define DW_OP_convert		0xa8
+#define DW_OP_reinterpret	0xa9
+
+/* GNU extensions.  */
+#define DW_OP_GNU_push_tls_address	0xe0
+#define DW_OP_GNU_uninit	0xf0
+#define DW_OP_GNU_encoded_addr	0xf1
+#define DW_OP_GNU_implicit_pointer	0xf2
+#define DW_OP_GNU_entry_value	0xf3
+#define DW_OP_GNU_const_type	0xf4
+#define DW_OP_GNU_regval_type	0xf5
+#define DW_OP_GNU_deref_type	0xf6
+#define DW_OP_GNU_convert	0xf7
+#define DW_OP_GNU_reinterpret	0xf9
+#define DW_OP_GNU_parameter_ref	0xfa
+
+/* GNU Debug Fission extensions.  */
+#define DW_OP_GNU_addr_index	0xfb,
+#define DW_OP_GNU_const_index	0xfc
+#define DW_OP_GNU_variable_value	0xfd
+
+#define DW_OP_lo_user		0xe0
+#define DW_OP_hi_user		0xff
+
+#endif /* __ASM_GENERIC_DWARF_H */
-- 
2.20.1

