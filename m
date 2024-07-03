Return-Path: <linux-arch+bounces-5238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B9926619
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2987B1C203E2
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21A1822D0;
	Wed,  3 Jul 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugox9121"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24B2BD19;
	Wed,  3 Jul 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023989; cv=none; b=MEGOkkUoqJmQNnTvgj++Y0afX6DrA8Cd2rR/l8XE/XSYH12BVKD0H5GQT8yWyzPVZu4PkCwAdJ8j5AYF5m6Ql0ftnBFr//vjkVMjxzz3wC0zzm0yPfaRePhgTOSrLwR9pTP1i1EnK6bVQlEJkOjdHoudA7Pqm1TOpKOkXtLU7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023989; c=relaxed/simple;
	bh=Uk8SKD6gxWX0gT+33jY2Nt6NqxCDIB3Pn7INT3sy8k4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+CBnR8Xm3/00UKW3/lNKNXJC4PD99MpI6EWrpe3Q+eyC94dBUapgO3zlrRTh+BsMXpLhs8fM5ps46uw4Lv2rbsHB7+oNR+AXV9UAOlUV28cbxmx0T89TXyzzqzjj8bM+Zg07Zussg/Ufk5KpKadz5tuoyWXRlHSyPJky/teMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugox9121; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d853305abfso585154b6e.2;
        Wed, 03 Jul 2024 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023987; x=1720628787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3L4z7hSroOuwsuipXwj/IN76KXKnPgl4yK5C8eJ7Ok=;
        b=Ugox9121ITGG06AZ5J8ejhKmFJAGcWs8TNsKBMW/e7rjcb498Por6bHvSdLs9crNhp
         /oJdhIYm8LcljfpBio5hBqHbjdcPCX4LOCIRfmfgW0b3NKEisbt0G3kA/HYjKu1C3D30
         ef79+AKkgUFtkRY+SA7Eu5BE3hA8+um5mrgBT+Tnmijkz0apj3mif1m+WrOcw8SNhWsX
         4a6KdRoHBezjtu8W1WThHR14HHFTKyCdo7VG6+06FpvdLfN13OqjaWUDVkY847dujSGe
         taDeAOz116asm9pcQM/5DwFKWbuSMrPy9+uU5VB8UPFfT0UqdIFBLqYikXcqBsjYAr4N
         Wujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023987; x=1720628787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3L4z7hSroOuwsuipXwj/IN76KXKnPgl4yK5C8eJ7Ok=;
        b=RFnoZgdODKnv5G2xxLYMXUCKi4ZIQOXbCk1CIj6oBrrTyC3eH1i5HUJQmFQwLSMo2D
         dzGLyDfyRhisWwYADFhdHpdhtOthg/Cq5hzFPBAcvdr2AH2zbDyV8UPKzD+LtZkUezHg
         rzJn21rU3jdsQZBBoHCImFr7yU0TRQd0kqVNbR/EWcqB4VbeNZWAljZ0Khq/35fWmam+
         Qh2Ahv+0Mpr+CqF7NaDio9Y+FYucHVl2X8hdQFti01kOuXu/dl7hiqMfBlMS78DTUxxj
         ifyRJJsVuvdute1/5FWGaCxZpt8RraaaeH9IK/hira+fNgRshLZjUknuX7Io/SaQt/+p
         BTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF/1MthfG9W82ulHKWhwEHG4tWhfS0NgNDqp6YP5NCO8dtB/SFw2pxkiNzrvvX3Ztfh32xozI3RWL2gTbl70z0XBL9Aj3rghRs3ZAf8oFVT4NA4+gklGb8GShQ5/p+5RN2b748G0MdCrWJ
X-Gm-Message-State: AOJu0YwRxfNYVph4nmM4umtlnLcBm+lEtXiVa4H8Y69O72tu/BuiTyF9
	d6iLCiH+1yYTVhSHF9Zatrk5S5mfrbOemFGQ81VkO2sYA92RUNml
X-Google-Smtp-Source: AGHT+IEyVyUiYLLSoPl2liXg/YKC21xisWvxAX/7YL0rN+iIfSsx5LzU/hQHjBPpSvLWLIFXEE4mEQ==
X-Received: by 2002:a05:6808:bd5:b0:3d5:6413:2138 with SMTP id 5614622812f47-3d6b2d189afmr15501833b6e.12.1720023986849;
        Wed, 03 Jul 2024 09:26:26 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5df21b3cdsm9456786d6.113.2024.07.03.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:26:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9674F1200068;
	Wed,  3 Jul 2024 12:26:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 03 Jul 2024 12:26:25 -0400
X-ME-Sender: <xms:sXuFZl2oKkz-zL6Ff7EvTfz2YDiqa29wEVmyslPRc_caHM_uqWGdpQ>
    <xme:sXuFZsFZH-Xhlfgt17QEYCsTEub_LCrSKNxzKqSFZVwVd6FhxSn_khEY-h7KIoYIU
    9HyNjvSTadnrUuzAA>
X-ME-Received: <xmr:sXuFZl71SMwi_Q_mo39A6gFtUXidUC1RFzFx1E5JIKp7dIttb-4DPIIl_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:sXuFZi1ZDoNFjIUOhyABWuvJsFbPxrDLJAeUw9dx_c3dQ3cCvTH0Eg>
    <xmx:sXuFZoEq-ih8SkLyfJWOWivzU7-hDlU4REhE2mxbjGdcEMscrV5Keg>
    <xmx:sXuFZj-bhsLF9QFw537JwzotNRaLSjb62ObxpjLfX25fz7hzHX7AvA>
    <xmx:sXuFZllFfPXhIip0CG5K1qEr2E0SCqj2YsE6z6u6UYFnwXh0LVOPaA>
    <xmx:sXuFZsFJ9FAZ152dnxITOtxpnhoqE0G5i3HlzeLHGkw0uaTWa1D0Qgu_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 12:26:25 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,	linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,	rust-for-linux@vger.kernel.org,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH] MAINTAINERS: Add the dedicated maillist info for LKMM
Date: Wed,  3 Jul 2024 09:26:16 -0700
Message-Id: <20240703162616.78278-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A dedicated mail list is created for Linux kernel memory model
discussion, and this could help more people to track down memory model
related discussion, since oftentimes memory model discussions would
involve a broader audience. Hence add the list information into the
maintainers entry of LKMM.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f2047082073..a77bd8a49cd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12796,6 +12796,7 @@ R:	Daniel Lustig <dlustig@nvidia.com>
 R:	Joel Fernandes <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
+L:	lkmm@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/atomic_bitops.txt
-- 
2.39.3 (Apple Git-146)


