Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3F356325
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348719AbhDGFfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345238AbhDGFfE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98CEC613CE;
        Wed,  7 Apr 2021 05:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773694;
        bh=yzTHByr3GvboIW/T6xufocsK6BWzHcPe3Ttz3XpWwHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2v8znZRcentw4aDHVudeeDQ/PA3S8rVznRDTSOlpd+Z+N5RX14c8NJkCp6RxqaRX
         tHlK9Xuu5BXh93xQMg1XF8tfkCxs6WiBjNLBOr/ML8ScWSILeZxioURieZH9XApQuZ
         zRGEnxLoKQcU/2n6F8/c0HMu3d3pKEB7qKHNND8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 06/20] kbuild: scripts/install.sh: handle compressed/uncompressed kernel images
Date:   Wed,  7 Apr 2021 07:34:05 +0200
Message-Id: <20210407053419.449796-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For x86, the default kernel image is compressed, but other architectures
allowed both compressed and uncompressed kernel images to be built.  Add
a test to detect which one this is, and either name the output file
"vmlinuz" for a compressed image, or "vmlinux" for an uncompressed
image.

For x86 this change is a no-op, but other architectures depend on this.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/install.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/install.sh b/scripts/install.sh
index 2adcb993efa2..72dc4c81013e 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -49,8 +49,18 @@ verify "$3"
 if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
 if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 
-# Default install - same as make zlilo
-install "$2" "$4"/vmlinuz
+base=$(basename "$2")
+if [ "$base" = "bzImage" ]; then
+	# Compressed install
+	echo "Installing compressed kernel"
+	base=vmlinuz
+else
+	# Normal install
+	echo "Installing normal kernel"
+	base=vmlinux
+fi
+
+install "$2" "$4"/"$base"
 install "$3" "$4"/System.map
 sync
 
-- 
2.31.1

