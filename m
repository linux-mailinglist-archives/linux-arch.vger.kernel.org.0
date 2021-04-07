Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0457E356341
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbhDGFfa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348785AbhDGFfV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BB7E613CE;
        Wed,  7 Apr 2021 05:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773712;
        bh=ceCRkUFPQ18/GAzGPcuYnwEBnMTGiXa4tglmN9EQyEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGy8Sq0s+WIxeUAsWcmLiv4eMjH+0Q7J/MM/NuOMS/Tm4E8WoopeoLQ+SX/a/pkWq
         xj/JL0qHd0yhUQcyqjroSTIjSFDraftoHtZWoW6aPpeL9lr2IRSrcB15I3xLJ45Yns
         3q66iRsPQC8A0VwqF0uGZZbBBAS1G272878xIABM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/20] kbuild: scripts/install.sh: allow for the version number
Date:   Wed,  7 Apr 2021 07:34:06 +0200
Message-Id: <20210407053419.449796-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some architectures put the version number by default at the end of the
files that are copied, so add support for this to be set by arch type.

Odds are one day we should change this for x86, but let's not break
anyone's systems just yet.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/install.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/install.sh b/scripts/install.sh
index 72dc4c81013e..934619f81119 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -60,8 +60,19 @@ else
 	base=vmlinux
 fi
 
-install "$2" "$4"/"$base"
-install "$3" "$4"/System.map
+# Some architectures name their files based on version number, and
+# others do not.  Call out the ones that do not to make it obvious.
+case "${ARCH}" in
+	x86)
+		version=""
+		;;
+	*)
+		version="-${1}"
+		;;
+esac
+
+install "$2" "$4"/"$base""$version"
+install "$3" "$4"/System.map"$version"
 sync
 
 # Some architectures like to call specific bootloader "helper" programs:
-- 
2.31.1

