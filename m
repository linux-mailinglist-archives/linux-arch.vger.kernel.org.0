Return-Path: <linux-arch+bounces-13999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1AFBCC68C
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F136A3BEFDB
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740F92D0C9A;
	Fri, 10 Oct 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2MNdXQh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C05275AFB
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089401; cv=none; b=pegoKmANb/7x2XJ0HyzBqj1TICx67KSbpjWIJVPDv/pkDBQ8FPhyW9eefrB0w9zCGhINY7hn+R1S6jZt02/4TOB0Ci2l9j91lA73EeUwsdXVM/FaL1Jez7VNyvMtneThvb7bJyusl/8fKyvY0i3ebs0AR5+Coj5DP+iDI6OikQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089401; c=relaxed/simple;
	bh=tfJwv3nqlpDtjcN28xzwLtu0Ad/Qk3DuNUw19bGFdw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKJzvrl4pVmNjmjsah4qoqlk4ufg3UvKS/5vUUtCDy7JYXallIoFHjmRosdbnrocITQFQ/fMxIJWWEddFO86drB0LeXez6I9P8oq59DiYSLNEMO+p0pJCgbLQCadJMRYjzQCT7E8d5PEcnZFndzvAgq7FWcETPcLKR6E3sZIIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2MNdXQh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so17135465e9.2
        for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089394; x=1760694194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmHzldTWpRVGaYiRV7mqVTmbw8wTd7DjVDHFKbOWCEM=;
        b=H2MNdXQhBP6UZRIf427UJPOaBPKLw53ezfUFHqraxZPLItmNzxyiaxGWwwZw5KnSVm
         +coy6QRPj4Ko0vYtaep45sJwuLKzSNfQ8Y7YCUJrEKs40bAzoMrJyBPxlngY0CUhZ2nz
         MJzzl6pASGIC1HeeEoVEuSZIv11I9yr4Xh6mLzABxM9BoAd7pHlvuaBSm4nxtXKd65x2
         6Jlmoylazu/vg7ORaRSBTN2JFXA4Gaq+37SnXVMXDrh+yhe/5G/CkVovRVDxmPHYaNOc
         c2eGNEvTd6/zFDTK1NRsZDPCv590fYmLNC4Jm0tz+g2ZBLExX6OzvFoBW2NiPYvZCllE
         RaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089394; x=1760694194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmHzldTWpRVGaYiRV7mqVTmbw8wTd7DjVDHFKbOWCEM=;
        b=H8O5mheKXfKRU8SIa5OKre0wg6COKw3IMiuxoi1RMPcJt5mSWwGAqUlZ/JCSpvn+xK
         LXMVtAHbZgrPZVMAFJNdV8hb6t4fjin6U+oETtquTZlyHZIIilaKuYSiJHoHjk5tlK0V
         WJa0UYn6lhwd9lUvJHrKYRUQjASqtw9LgvVzcf+1qzT3V/xygUqIAq9N5GASnXSwsaeF
         t71YMBkL3oGoxKf6f2Suylq+ODYmntZeJs72D2sYPh0Qxn87M+ujHEmPZ8RZ4fu6bWk9
         dkQeC62w3f1mSI6qVTCxRSSv5BJulQq3RuLLnp0n1jm9DSH5IZEhwi+7NKmsyUuoWqzh
         XnRw==
X-Forwarded-Encrypted: i=1; AJvYcCXbW7rFqXi1FwRcDOJg63rWLfC5Ecr74KONkOlaSZEiQi8oIanHiZI927VZj1irmAQ7KgnZ2o05WWyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQa2VHb4v/I7snCANvWQ5WituzV4IMVfmQxTSl6DsEpF33MB2V
	trLnEB9GXNQJSih87oEI8hVHhDNITtxf8qB4V4AuPCWoiGwOcFB2d47w
X-Gm-Gg: ASbGnctC14duCPREJQEW6DT2ofE3kIhJF4bH7u20IIv1f7AObfYh9SLd3PqHcfun2tM
	AMkxAzrKCbawlN1YuxJZq8fSsg5JHqwHxt0M1vEc/WFf6T5aybuxsS5YI7H85uZ8YfwNo9XPP2k
	LkguHOKXohGVYz1Rk4dBu8n3SWnPJzYTrgldiBGA+/HnNKhpqiRv//pEHH+jv5wpCzhDuC0TzYK
	rY0FElLO0Vjiub9JZw9TdG9AxgPFaOxl/8hzswP5yNbRwa03h+ANRjJFjRrMfYaF/4YXmw9QtkV
	uGSJeOhA85k9UlLBXI/kDay1LGUdRuFJcuoe79GfBkhtpIVVyb/LLyXOlLD2bDGISHkGzxioAyO
	BDRE5C03e/dU+IR2ljQjyHK11Dr+ujSM3gEeeJLDLOPmUFCFK
X-Google-Smtp-Source: AGHT+IF9s+/76+HLGw2mLZk76tGq6/V4j0p5f2hCMj0ootyyX2pqmy4ieClzRxxY9elYI46O7lbdMg==
X-Received: by 2002:a05:6000:2dc8:b0:425:6866:6a9e with SMTP id ffacd0b85a97d-4265ef6e5c2mr4984366f8f.0.1760089393527;
        Fri, 10 Oct 2025 02:43:13 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e8309sm3283123f8f.50.2025.10.10.02.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:43:13 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v2 3/3] init: remove /proc/sys/kernel/real-root-dev
Date: Fri, 10 Oct 2025 09:40:47 +0000
Message-ID: <20251010094047.3111495-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010094047.3111495-1-safinaskar@gmail.com>
References: <20251010094047.3111495-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not used anymore

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab937d0..cc958c228bc2 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d4f5f4c60a22..fb0c9d3b722f 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -8,31 +8,11 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init no_initrd(char *str)
 {
 	pr_warn("noinitrd option is deprecated and will be removed soon\n");
-- 
2.47.3


