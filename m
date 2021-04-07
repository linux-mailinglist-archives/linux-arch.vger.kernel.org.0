Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2735631F
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbhDGFe5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345230AbhDGFe4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:34:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65CCF61168;
        Wed,  7 Apr 2021 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773686;
        bh=Ap6X9FPkMU0Lq3Uh/N+daHn0QRFCYA0Bh3YUBOeqXvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDJNB2hiQMshLeFAIxxzwHkK7jXwMfsDHFZal5KRlsyjLWRbVPgxrPVfVpGcEyHHC
         icS/c2eIoytAOA41UJtHXRMT7QCrr/3sLMnhpt6qUybW8phqpYRBQ+/NcSXZeMWFUx
         MFNF4XttedJPsMkupgscXzDdzV9qorRUdDnr5dCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/20] kbuild: scripts/install.sh: provide a "install" function
Date:   Wed,  7 Apr 2021 07:34:02 +0200
Message-Id: <20210407053419.449796-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of open-coding the "test for file, if present make a backup,
then copy the file to the new location" in multiple places, make a
single function, install(), to do all of this in one place.

Note, this does change the default x86 kernel map file saved name from
"System.old" to "System.map.old".  This brings it into unification with
the other architectures as to what they call their backup file for the
kernel map file.  As this is a text file, and nothing parses this from a
backup file, there should not be any operational differences.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/install.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/scripts/install.sh b/scripts/install.sh
index c183d6ddd00c..af36c0a82f01 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -27,6 +27,19 @@ verify () {
  	fi
 }
 
+install () {
+	install_source=${1}
+	install_target=${2}
+
+	echo "installing '${install_source}' to '${install_target}'"
+
+	# if the target is already present, move it to a .old filename
+	if [ -f "${install_target}" ]; then
+		mv "${install_target}" "${install_target}".old
+	fi
+	cat "${install_source}" > "${install_target}"
+}
+
 # Make sure the files actually exist
 verify "$2"
 verify "$3"
@@ -37,17 +50,8 @@ if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
 if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 
 # Default install - same as make zlilo
-
-if [ -f "$4"/vmlinuz ]; then
-	mv "$4"/vmlinuz "$4"/vmlinuz.old
-fi
-
-if [ -f "$4"/System.map ]; then
-	mv "$4"/System.map "$4"/System.old
-fi
-
-cat "$2" > "$4"/vmlinuz
-cp "$3" "$4"/System.map
+install "$2" "$4"/vmlinuz
+install "$3" "$4"/System.map
 
 if [ -x /sbin/lilo ]; then
        /sbin/lilo
-- 
2.31.1

