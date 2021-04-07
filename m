Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0EE356322
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348710AbhDGFe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348708AbhDGFe7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB888613B8;
        Wed,  7 Apr 2021 05:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773689;
        bh=wgqLKCpv5Q1vEaaFl8xvuInNNea8k2m+fFzOdqUbyw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FOc29ZGjx5iCyoeD/hFnnJMp6MK22rKftLmPC/k2fkvWM/woCpNyQx+frfwPs3OG
         e+SiqrJrJX+j3b6BuVmjurM3bKSh5vIHLpHIsqQdkYAxgPJa8FQmJ31QBIrtU+o/bF
         CB3tPwEEateROLJts7jwJpvdbDeAhoNCm0QxJjXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/20] kbuild: scripts/install.sh: call sync before calling the bootloader installer
Date:   Wed,  7 Apr 2021 07:34:03 +0200
Message-Id: <20210407053419.449796-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's good to ensure that the files are written out before calling the
bootloader installer, as other architectures do, so call sync after
doing the copying of the kernel and system map files.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/install.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/install.sh b/scripts/install.sh
index af36c0a82f01..92d0d2ade414 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -52,12 +52,12 @@ if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 # Default install - same as make zlilo
 install "$2" "$4"/vmlinuz
 install "$3" "$4"/System.map
+sync
 
 if [ -x /sbin/lilo ]; then
        /sbin/lilo
 elif [ -x /etc/lilo/install ]; then
        /etc/lilo/install
 else
-       sync
        echo "Cannot find LILO."
 fi
-- 
2.31.1

