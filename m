Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931248B85A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfHMMTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:19:54 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48061 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfHMMTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 08:19:09 -0400
Received: by mail-qk1-f201.google.com with SMTP id y67so4123894qkc.14
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ey51rOQs6pREeIh9cdmyj66W3XNY9zI3cHQpc2k+3HQ=;
        b=Kj2QCgHK1EXGXCElMh+j+E+YRK/wfgittksUPJYKcCq2HTXcsAROuHGcD8lwzMPeKN
         FRuEY4ZJ4B5K6zrA1HwL334EfWDTWdX3NtetiJHeWa9GorOQdftb7ZFl6EKSx4u3xZc/
         7wihld+w2BBSts7l0IWFmsA8phk/UcL6zJVHc/saACvhutCrFbaf8mO23uze0QWnNBrq
         vYTou4ilb8mGMgPL02Xng92+rEko2PdVT7rfXODuJ6MfFN3kroS9fkNmsFz5YKN59B1J
         z/cX3txyE3JspEYroOPPq3rlFHs4ewel3KUPhHTQrUFBOOUrKm5bW9fgQpBKQKrxy7dA
         pBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ey51rOQs6pREeIh9cdmyj66W3XNY9zI3cHQpc2k+3HQ=;
        b=K4BruhHylpBmv2eRZLm+bCH1l75kCOj6P0Q5yjUYdTVu7kwY/wfSPt7kpjSsc9CkCc
         BtJlHmX873Atd+0pNSCe5bgFZEheL1lLMqQ0EHL68Arbp1iqyu3p9KZtt54u0QRYBVR2
         7jWnUKKJPPwQY5ESTJzr9i+eOgx626jITPn08NRskSbJdY68H0UNXez4N/PYwsQfJOJt
         ZMYK2MEogBzJWr0IzyVZ+DuS4g2LFDi9DxM4QPYzTin2h5CN9AetcnyYfKOqoGGD0uce
         ToTD+kxm1cYuCM0rqA1S0qfH0ZbmzPdL+AWOR39yl2prme+zFs8W0zAqj4vqjzWDqXCS
         k5kg==
X-Gm-Message-State: APjAAAXKPTkwAjls6b4LGPh3bBMiP+8KmRj8LxMQqagWdT8k9TbJHLiT
        7RE7lNoznGcbQvCAA91POruvpDnUFj4/dQ==
X-Google-Smtp-Source: APXvYqx8Z3ce2Fq34vvTXoHfRI3jPxZxSV8ZFlwOArOAxzvMMWLUaLTe8i8AZbmoFtb4lXGU8fZ6nZcq2n3UrA==
X-Received: by 2002:a37:6844:: with SMTP id d65mr33008934qkc.398.1565698748030;
 Tue, 13 Aug 2019 05:19:08 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:16:58 +0100
In-Reply-To: <20190813121733.52480-1-maennich@google.com>
Message-Id: <20190813121733.52480-2-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 01/10] module: support reading multiple values per modinfo tag
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org, maco@android.com
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similar to modpost's get_next_modinfo(), introduce get_next_modinfo() in
kernel/module.c to acquire any further values associated with the same
modinfo tag name. That is useful for any tags that have multiple
occurrences (such as 'alias'), but is in particular introduced here as
part of the symbol namespaces patch series to read the (potentially)
multiple namespaces a module is importing.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 kernel/module.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 5933395af9a0..a23067907169 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2481,7 +2481,8 @@ static char *next_string(char *string, unsigned long *secsize)
 	return string;
 }
 
-static char *get_modinfo(struct load_info *info, const char *tag)
+static char *get_next_modinfo(const struct load_info *info, const char *tag,
+			      char *prev)
 {
 	char *p;
 	unsigned int taglen = strlen(tag);
@@ -2492,13 +2493,25 @@ static char *get_modinfo(struct load_info *info, const char *tag)
 	 * get_modinfo() calls made before rewrite_section_headers()
 	 * must use sh_offset, as sh_addr isn't set!
 	 */
-	for (p = (char *)info->hdr + infosec->sh_offset; p; p = next_string(p, &size)) {
+	char *modinfo = (char *)info->hdr + infosec->sh_offset;
+
+	if (prev) {
+		size -= prev - modinfo;
+		modinfo = next_string(prev, &size);
+	}
+
+	for (p = modinfo; p; p = next_string(p, &size)) {
 		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
 			return p + taglen + 1;
 	}
 	return NULL;
 }
 
+static char *get_modinfo(const struct load_info *info, const char *tag)
+{
+	return get_next_modinfo(info, tag, NULL);
+}
+
 static void setup_modinfo(struct module *mod, struct load_info *info)
 {
 	struct module_attribute *attr;
-- 
2.23.0.rc1.153.gdeed80330f-goog

