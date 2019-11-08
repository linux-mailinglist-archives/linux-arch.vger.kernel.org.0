Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78837F3F45
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfKHFEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:06 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46039 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKHFEF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:05 -0500
Received: by mail-pl1-f175.google.com with SMTP id y24so3224447plr.12
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AZNr+UZi9FN5KTkWLNlzFX0rObVke+OBsR7u63hpJY=;
        b=uKZLKvVI6po1dkGqIzQlWspBvYyW+h166XEHTI3ZokGBItEW2DtvWqSFxJSWnTbYhl
         kj0/+7cgt2OxXfzHg9GCjYSiFEYapv0bd7Xl+KwmEBxO72I7EcONYN0adv/qWWcNl4bI
         w/HjIaVqbAVf9mNxAytgA6Dcjak1AVyn8H16qB8BIB12S6cDzWkmKqd3xesIGcHWzbjS
         w4OxNdyDG6q6utanheVom6+pQP1hrJTu2n6INSeeHKRDAi1ydMLm/1zrpWi0Ndfxajx9
         c5M1GTmFWF8c1XN0189YYwyCpa2A2CoBEv+JAcaTthcmlKOJATs4ztLRULZjw094enxC
         Db+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AZNr+UZi9FN5KTkWLNlzFX0rObVke+OBsR7u63hpJY=;
        b=R3Bxuonv/CA4O0lwVujjOYNaiv516qf8vrRakHWAaPw1yJbrjfdEC8NBgP33YyN2qc
         CcwZRmChk1/bJOa3WTkpKVcnTzOOCkdEbm3xbJjW4CTtGjNyB5Mf3NiWdbGTEgsf793I
         DvKOInAn0c8LVdocbeffJgXCdyZJUjR1FCDSneEDTNfeuI/24Ffe8v01pJzakkRV1JSH
         NkbzUZ2cnxIfuzr6orn260m/YI9KnwpI+sEfTJjLGKwNzZTZ5HrTneoS+7vEHoI04FFd
         K+oEzj5hE7eNjVR9+76qSl1RWkbAoimEECfmsI1lJwNfkPocjPc2CFyB9AO9AQnsX2CN
         huPQ==
X-Gm-Message-State: APjAAAX4KIqRrHs8O7l5rrldzJsptZ9dSqe/oCX0L3KgvJfngXbIwQQr
        idDUNHZwbkqM3rtR3NIVxAc=
X-Google-Smtp-Source: APXvYqyw8nCSfgOHZ/xkKHHbTznrQfS9zcl3FjL0EKCZjV0fztbGxLiNjIJrqxkp2ptVvi4nQQuB5g==
X-Received: by 2002:a17:90a:5d0f:: with SMTP id s15mr10620930pji.90.1573189445009;
        Thu, 07 Nov 2019 21:04:05 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id v15sm1293182pfe.44.2019.11.07.21.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:04 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 9F7B3201ACFE1F; Fri,  8 Nov 2019 14:04:02 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v2 25/37] checkpatch: avoid showing BIT_ULL warnings for tools/ files
Date:   Fri,  8 Nov 2019 14:02:40 +0900
Message-Id: <7150a514b3ebc50f65fc8ed328c31df0e999cdc2.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Directly using shift operations in userspace compiled code should not
trigger warnings as BIT_ULL macros are not available outside the
kernel.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..e739f565497e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6313,7 +6313,8 @@ sub process {
 		    $line =~ /#\s*define\s+\w+\s+\(?\s*1\s*([ulUL]*)\s*\<\<\s*(?:\d+|$Ident)\s*\)?/) {
 			my $ull = "";
 			$ull = "_ULL" if (defined($1) && $1 =~ /ll/i);
-			if (CHK("BIT_MACRO",
+			if ($realfile !~ m@\btools/@ &&
+			    CHK("BIT_MACRO",
 				"Prefer using the BIT$ull macro\n" . $herecurr) &&
 			    $fix) {
 				$fixed[$fixlinenr] =~ s/\(?\s*1\s*[ulUL]*\s*<<\s*(\d+|$Ident)\s*\)?/BIT${ull}($1)/;
-- 
2.20.1 (Apple Git-117)

