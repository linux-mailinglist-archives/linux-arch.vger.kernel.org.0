Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABCC42C82D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhJMR77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 13:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbhJMR75 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 13:59:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A967C061765
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c29so3187421pfp.2
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rp/JVQM4Zv+z3R4Pp047EZ8OQIJJhiuVH2ShyShd8FQ=;
        b=AGf5J4fnB0CIf5oxKxNnebjHnga1X27gio9TLxKDp4cDcoEwjJkAv0RTYHBrcorpdn
         SDIGdpyqqgIZhXiJZTCki+bz8p6xidCP/Hiysv2vJB9Nael8hi4PJ5xzrSnIVLjQWXII
         4tUmK26ouXhNJAnDDBCpgiRcfyPY8NmpLk3RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rp/JVQM4Zv+z3R4Pp047EZ8OQIJJhiuVH2ShyShd8FQ=;
        b=O7zLpOIP68UkYpNAsQ8sMb0RryGdPZW43G7ZQz+Zbs9lciVxNACBYoCDOu2VLTXS1U
         ODwa0gWubhqZQFxQ2lCOYNM290seTPIF90605NK+1iSaZPYLH/egttHfh4wlrKFAWDz4
         gukqIcgM4gvYarJcIi4ihIOd6IdAi+yYRoqHP7ql53NDEbLbkxrCL8eoVejBRJLGs+mw
         ZImP9B7nbPNmN/b7KgTaRuubc0cmKhFL8JJ7dtDFQbnwv+8f9OAbGotyErB/Cngj79wW
         qUWGcsGMPSoYrcIuBtHFconOpXIKh85h+mEypxMsJpzczMVerFTVzmsEYbLFfWKCnbqB
         EMcw==
X-Gm-Message-State: AOAM533+V4Vo6w1BCgJP/s5XMboPnaEpNI9c8yOyK88tfvTlKgxLvtRx
        pP+YZrSXi5IK8zCAdd8j84WPyA==
X-Google-Smtp-Source: ABdhPJzzqggQEfz5rWpsNrPSPD8dksHrIMYyrtHC5TUFXM/iotEJD9Nvzsjyf2oRj3qDSc5gKHiYFQ==
X-Received: by 2002:a63:e10d:: with SMTP id z13mr442755pgh.375.1634147872778;
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i15sm184365pfq.21.2021.10.13.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] x86/boot: Allow a "silent" kaslr random byte fetch
Date:   Wed, 13 Oct 2021 10:57:40 -0700
Message-Id: <20211013175742.1197608-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013175742.1197608-1-keescook@chromium.org>
References: <20211013175742.1197608-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; h=from:subject; bh=QYsHdjNAtpfLq0fC/fv08OJWSBanqdK3WCZTPqw/9/s=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhZx4V4ONsRXTnUoTv5VE1BbZVcnOmEFIIPdvBhYBT k3QraSKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWceFQAKCRCJcvTf3G3AJpVREA CkYyOkUtZaF+Mud9ViQGaUPLcCI1HQbGZwtEHWyhrvXtV6LhGtQllhonYGicjqofzZPd6VFr3wpfP6 4B4EpTlXgvkr83DGSN0Lh2/z3O2QIrDsz3zXQYwMVVAqWY+9BVuNUgFtpiHrKODBFfcRHVAtCH3Msu hwLWa+7A3XxKUWbpLw2pmyIydVpuPAFZW2JZ/5tZDxhG6UjKgw+hu99phR8lL6cx4PlTt4+Mp1W18g JJfAkLhKJdvmOSAMUIZWqnnw+iM6+9/bVdFzCEJcMHnFsATRc1yVv2IaTkZpVXMLV96PAdgGny4zBk oX6IBB6UB9aj60WoVaONIxaM+ebV2o6HfE5UFP7DmBHA6IPMVUpfK9F5kUWvkKrH71FPqoOwJuc6jH l2Lu8GguqnBYXTRPPTJgOAxt3AahlwxlNlBs6TSRYc6RBGirisMTtlsZjdtbkL2vEnDd2QW6q0O2W+ L75t7fTCJq5Px5dBCU8MDIvhC4MwHyMy3t45oivfYs+4oIPeguiVsxV66z6vS4MryzM+JHT53eZ498 STKepS+eXsnCSzBbZUrxsvbe4Z8kpDR1EI+uII91hWxJxT98GqYesqXbWrevxmMMv7zoS3WsAi3MMG tkQBpRDL7CXB0eol2vprTxzr7eI9rZsWDpskFepd9u98TYVSYf0HFRHyonkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Under earlyprintk, each RNG call produces a debug report line. To support
the future FGKASLR feature, which will fetch random bytes during function
shuffling, this is not useful information (each line is identical and
tells us nothing new), needlessly spamming the console. Instead, allow
for a NULL "purpose" to suppress the debug reporting.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/lib/kaslr.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index a53665116458..2b3eb8c948a3 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -56,11 +56,14 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	unsigned long raw, random = get_boot_seed();
 	bool use_i8254 = true;
 
-	debug_putstr(purpose);
-	debug_putstr(" KASLR using");
+	if (purpose) {
+		debug_putstr(purpose);
+		debug_putstr(" KASLR using");
+	}
 
 	if (has_cpuflag(X86_FEATURE_RDRAND)) {
-		debug_putstr(" RDRAND");
+		if (purpose)
+			debug_putstr(" RDRAND");
 		if (rdrand_long(&raw)) {
 			random ^= raw;
 			use_i8254 = false;
@@ -68,7 +71,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (has_cpuflag(X86_FEATURE_TSC)) {
-		debug_putstr(" RDTSC");
+		if (purpose)
+			debug_putstr(" RDTSC");
 		raw = rdtsc();
 
 		random ^= raw;
@@ -76,7 +80,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (use_i8254) {
-		debug_putstr(" i8254");
+		if (purpose)
+			debug_putstr(" i8254");
 		random ^= i8254();
 	}
 
@@ -86,7 +91,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	    : "a" (random), "rm" (mix_const));
 	random += raw;
 
-	debug_putstr("...\n");
+	if (purpose)
+		debug_putstr("...\n");
 
 	return random;
 }
-- 
2.30.2

