Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415812A4DFF
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKCSMZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:12:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34119 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgKCSME (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:12:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id y16so20114329ljk.1;
        Tue, 03 Nov 2020 10:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmR+OgLQpXiz9C9It/pksOvqMCO0WrxIHSJ60EhO0sc=;
        b=oux46P4vgVZdof1jzj8LRZFje/Rej+BWquKQhbOVV7Nm67GLsIj8NzPlkgz0NuTLpK
         TWth9aAd62ZFGkNzphsr0rArbRh/D4l8hmPDCUJtpPMjIc5U9lJb1Bb/m38nGAAvFRjY
         zuPYJyhdqgVX3sy1pPQJTTzIdjSFehdqzjJeGEboknxBxInla/qNoPmlYEiIxAycHHxz
         RL18/OdrJt/eDeDPVUnNwMP72CILzRpNzFdS3XZwb2W96vDMceqRaF2QsbralKbKdEgQ
         pQwebMEV/dpRzDOOyjhQnoS4QvGIR2qcAnr3vTihZrUPkhgsdG9UuhHqCOJW33H4CU7I
         Quwg==
X-Gm-Message-State: AOAM53086B1QCRFAJCZF8t4qh4MoL7xUZGyeJiMebN2anWled5EPaPS8
        Om2R3W2n49Uma1/rwhhWw1AGOABWhG5pVw==
X-Google-Smtp-Source: ABdhPJz07sueJ3+iSzebkN7P4Ah4zYnUmAAYA1hmwphU/S9lC2YVretq83hvmXcayqIQwculOmRVWg==
X-Received: by 2002:a2e:7310:: with SMTP id o16mr9809475ljc.42.1604427122132;
        Tue, 03 Nov 2020 10:12:02 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id g20sm4540473ljn.134.2020.11.03.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:12:00 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1ka0mn-0002rb-PW; Tue, 03 Nov 2020 19:12:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/8] module: drop version-attribute alignment
Date:   Tue,  3 Nov 2020 18:57:06 +0100
Message-Id: <20201103175711.10731-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
References: <20201103175711.10731-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 98562ad8cb03 ("module: explicitly align module_version_attribute
structure") added an alignment attribute to the struct
module_version_attribute type in order to fix an alignment issue on m68k
where the structure is 2-byte aligned while MODULE_VERSION() forced the
__modver section entries to be 4-byte aligned (sizeof(void *)).

This was essentially an alternative fix to the problem addressed by
b4bc842802db ("module: deal with alignment issues in built-in module
versions") which used the array-of-pointer trick to prevent gcc from
increasing alignment of the version attribute entries. And with the
pointer indirection in place there's no need to increase the alignment
of the type.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7ccdf87f376f..293250958512 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -66,7 +66,7 @@ struct module_version_attribute {
 	struct module_attribute mattr;
 	const char *module_name;
 	const char *version;
-} __attribute__ ((__aligned__(sizeof(void *))));
+};
 
 extern ssize_t __modver_version_show(struct module_attribute *,
 				     struct module_kobject *, char *);
-- 
2.26.2

