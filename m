Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF78356326
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348734AbhDGFfF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345241AbhDGFfE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20C19613B8;
        Wed,  7 Apr 2021 05:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773691;
        bh=nADdg6PM/j4BMDvlY9mRZPDHGBnkM2Jn+KFDAec2UDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xKPdKMGmCnJqujbtVQPFWFBrjKsYjxexM8pJMjYN9Sppty8vctYiBQ9lIL6oxC5Ih
         HkAI4ZTZgJjmCrrw6Dln6p4xlKD586JvV7kcwH0Wn2fLSYNI/e5xyokeBZZWQVvNMr
         vpLOg92uNdZFeLU0H7nCo7H16hXq+cQwrTSX2by0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/20] kbuild: scripts/install.sh: properly quote all variables
Date:   Wed,  7 Apr 2021 07:34:01 +0200
Message-Id: <20210407053419.449796-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A few variables are quoted to handle spaces in directory names, but not
all of them.  Properly quote everything so that the kernel build can
handle working correctly with directory names with spaces.

This change makes the script "shellcheck" clean now.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/install.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/install.sh b/scripts/install.sh
index d13ec1c38640..c183d6ddd00c 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -33,21 +33,21 @@ verify "$3"
 
 # User may have a custom install script
 
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
+if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 
 # Default install - same as make zlilo
 
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
+if [ -f "$4"/vmlinuz ]; then
+	mv "$4"/vmlinuz "$4"/vmlinuz.old
 fi
 
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
+if [ -f "$4"/System.map ]; then
+	mv "$4"/System.map "$4"/System.old
 fi
 
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
+cat "$2" > "$4"/vmlinuz
+cp "$3" "$4"/System.map
 
 if [ -x /sbin/lilo ]; then
        /sbin/lilo
-- 
2.31.1

