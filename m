Return-Path: <linux-arch+bounces-628-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECFE803310
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294271C20A61
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15506241E4;
	Mon,  4 Dec 2023 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwcVCVE2"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CD101
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 04:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701693544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFtPPFlPjH6SVTrSMMFZ3PPUy8xNeziB9aHHtXxHnVY=;
	b=UwcVCVE2Gn26ki5ZPyKX8Ez4rSR/Ftv5OelqtDSUGonTDPFgKuJUqMX1qWV7aRzf95GVau
	jlBdKFxYDlik3qS0bRZiD9VoIeFFLlvhZj9xl8Ci9i7BuL79LWf4/FOsdFArdPIHHZ/BGv
	h+EDWeQ/Tc9NTcIlyhedELA9S7PL/f4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-YiePRUYuMrmc8GSsPdWWIg-1; Mon, 04 Dec 2023 07:39:03 -0500
X-MC-Unique: YiePRUYuMrmc8GSsPdWWIg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b473b7014so6456135e9.0
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 04:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693542; x=1702298342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFtPPFlPjH6SVTrSMMFZ3PPUy8xNeziB9aHHtXxHnVY=;
        b=aB+1XM4ueexbM3SP9RpOPh3F3VUD4sa1pbu4PmQDDg+/dAoxs17azZ/D3q7axP0PLX
         zU4sp3Zq6oD/mpoTs3W7vA7zfdEzKfdMzvIkakI49vMiOGsetLXYShxKRdv3z7i6GkgO
         zUVudUI2iNDdudcVb6xFvSE9P6Ci+6Z9IK0bI/kLcYzJIkgHMTeHnONyZDmfljt6utdK
         n6vv0VE37hnWfMXyhhKAtTLoVDMfXb0k2n6RJUs1tUr8umPFhZqsvfq1fys8dgqSfE0c
         BbGLs1ZWiF1NSzDSDdBuWdpDCyPTj1By4rYAWK1q4tmxFPvrLv0l7q5lb5ol2njyL1BE
         Ogwg==
X-Gm-Message-State: AOJu0YwUsp1MKVqzI5XWvrbfWQhrdOfZ9hfqZzTn6ebvLNK034Ee5rFU
	QEKySuBHZUm9F/+peeIaEkhzxWRAZiBXdmnbwj3qNhrrepq7sUpza71L54L/+G3gPO8sww6mCZE
	hHEA8qRYO526nJoBsxqq8ew==
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr20346587wmp.2.1701693542499;
        Mon, 04 Dec 2023 04:39:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa9D3Oq68dv0QV+vUk78rlYYf7kq5RJzRekj2cg40Dksne3tRnoCEbe7teyc0q5ukqXIbMgg==
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr20346552wmp.2.1701693542121;
        Mon, 04 Dec 2023 04:39:02 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c8:b00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm18355935wms.3.2023.12.04.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:39:01 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	John Sanpe <sanpeqf@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v3 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Mon,  4 Dec 2023 13:38:28 +0100
Message-ID: <20231204123834.29247-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204123834.29247-1-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_iounmap() in lib/pci_iomap.c is supposed to check whether an address
is within ioport-range IF the config specifies that ioports exist. If
so, the port should be unmapped with ioport_unmap(). If not, it's a
generic MMIO address that has to be passed to iounmap().

The bugs are:
  1. ioport_unmap() is missing entirely, so this function will never
     actually unmap a port.
  2. the #ifdef for the ioport-ranges accidentally also guards
     iounmap(), potentially compiling an empty function. This would
     cause the mapping to be leaked.

Implement the missing call to ioport_unmap().

Move the guard so that iounmap() will always be part of the function.

CC: <stable@vger.kernel.org> # v5.15+
Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
In case someone wants to look into that and provide patches for kernels
older than v5.15:
Note that this patch only applies to v5.15+ – the leaks, however, are
older. I went through the log briefly and it seems f5810e5c32923 already
contains them in asm-generic/io.h.
---
 lib/pci_iomap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526..6e144b017c48 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -168,10 +168,12 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 	uintptr_t start = (uintptr_t) PCI_IOBASE;
 	uintptr_t addr = (uintptr_t) p;
 
-	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
+		ioport_unmap(p);
 		return;
-	iounmap(p);
+	}
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
-- 
2.43.0


