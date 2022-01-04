Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F8E4842D9
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 14:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiADNyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 08:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiADNyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 08:54:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9CC061761;
        Tue,  4 Jan 2022 05:54:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id bm14so148817175edb.5;
        Tue, 04 Jan 2022 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpVl90tu1VudcwPIkxCnRiBMFYXENzbIbd3F9LCevcE=;
        b=pftNXnGBP9rGQLjvObrL2IxSnUvr9WpBwHdVkbRAY9AVbmd372Y1qN34M+b0K5uzT6
         Uf9+06lF+CIJn9WhjkQ1Wcl8CBNbgUWwmz/0gc2RoJvwSZw+G9nL61y2oGmDXLoOr08c
         fvCrse6ThXBPEM6+MbN3DivSwYqAosG5WDff3JwhX0Ih50ZRWamwbe4ryerFiHsFzLrg
         q3NIdzdw9QMIQmNui2R9cSQ75wy3Zutm/d+FH76Pe2aDmI33KvdKGYj8/6VyRsyXJ6Gj
         ROAVF6E6JLOyKp1bXKGXqYBoAxyBehx9z8VSVEoQ4JX1CLA87ddg5uV06MKQ43KJgSfi
         h0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RpVl90tu1VudcwPIkxCnRiBMFYXENzbIbd3F9LCevcE=;
        b=SlAmFG+kTrhmWleWHiIKbycBHSTRgJR8SjUAfJUrTMx6eQd4M14XU1Mr181oqvJgoA
         sNv/8k3Be9FdxwEiDjTW67W/6hR6xZAuODc79DbQlGkt/1KiNTC05TwXjYCVY8/BfvPK
         STw4RZyUb6whV/pKjZAO0nYFyfIJEYMftgWxAyz07PL1CAKcIbDBxO7QGcE+5cITNLko
         ZASatNZ4szK21sB5Y9IwgQ1V1odMZyMDIf0C83htHbFnmAVefiQX482a3OEepJwJITRd
         YGkxdXPgaEgEyqyuQvFQNkLhDSL2KLcoxGDtx6WfcbaUY4fXXtaXBTfdYT2PiW99IPl1
         BiYQ==
X-Gm-Message-State: AOAM532QY1Lj+MJqLtbqnUbox0U0FD49wsz32DfljMYWrjziTeUHoafh
        hdkAYaqcpXFNRHub9CqR+QI=
X-Google-Smtp-Source: ABdhPJw/CSFlsP/QAMlrC1V1/TOLkywsPYyIr83FJn+Ai6VmiIJRPTxJLnamZq4+J0QbklSXecEZIg==
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr37716359ejk.735.1641304473556;
        Tue, 04 Jan 2022 05:54:33 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id hd17sm11516052ejc.58.2022.01.04.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 05:54:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 4 Jan 2022 14:54:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] headers/uninline: Uninline single-use function:
 kobject_has_children()
Message-ID: <YdRRl+jeAm/xfU8D@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
 <YdQnfyD0JzkGIzEN@gmail.com>
 <YdRM7I9E2WGU4GRg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdRM7I9E2WGU4GRg@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Jan 04, 2022 at 11:54:55AM +0100, Ingo Molnar wrote:
> > There's one happy exception though, all the uninlining patches that 
> > uninline a single-call function are probably fine as-is:
> 
> <snip>
> 
> >  3443e75fd1f8 headers/uninline: Uninline single-use function: kobject_has_children()
> 
> Let me go take this right now, no need for this to wait, it should be
> out of kobject.h as you rightfully show there is only one user.

Sure - here you go!

Thanks,

	Ingo


=============================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sun, 29 Aug 2021 09:18:53 +0200
Subject: [PATCH] headers/uninline: Uninline single-use function: kobject_has_children()

This was the only usage of <linux/kref_api.h> in <linux/kobject_api.h>,
so we'll able to decouple the two after this change.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/base/core.c     | 17 +++++++++++++++++
 include/linux/kobject.h | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd034d742447..e1f2a5791c0e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3029,6 +3029,23 @@ static inline struct kobject *get_glue_dir(struct device *dev)
 	return dev->kobj.parent;
 }
 
+/**
+ * kobject_has_children - Returns whether a kobject has children.
+ * @kobj: the object to test
+ *
+ * This will return whether a kobject has other kobjects as children.
+ *
+ * It does NOT account for the presence of attribute files, only sub
+ * directories. It also assumes there is no concurrent addition or
+ * removal of such children, and thus relies on external locking.
+ */
+static inline bool kobject_has_children(struct kobject *kobj)
+{
+	WARN_ON_ONCE(kref_read(&kobj->kref) == 0);
+
+	return kobj->sd && kobj->sd->dir.subdirs;
+}
+
 /*
  * make sure cleaning up dir as the last step, we need to make
  * sure .release handler of kobject is run with holding the
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index efd56f990a46..e1c600a377f7 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -117,23 +117,6 @@ extern void kobject_get_ownership(struct kobject *kobj,
 				  kuid_t *uid, kgid_t *gid);
 extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
 
-/**
- * kobject_has_children - Returns whether a kobject has children.
- * @kobj: the object to test
- *
- * This will return whether a kobject has other kobjects as children.
- *
- * It does NOT account for the presence of attribute files, only sub
- * directories. It also assumes there is no concurrent addition or
- * removal of such children, and thus relies on external locking.
- */
-static inline bool kobject_has_children(struct kobject *kobj)
-{
-	WARN_ON_ONCE(kref_read(&kobj->kref) == 0);
-
-	return kobj->sd && kobj->sd->dir.subdirs;
-}
-
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;
