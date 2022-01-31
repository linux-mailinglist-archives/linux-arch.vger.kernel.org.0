Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C024A52A5
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 23:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiAaWxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 17:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiAaWxF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 17:53:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C93CC06173B
        for <linux-arch@vger.kernel.org>; Mon, 31 Jan 2022 14:53:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c76-20020a25c04f000000b00613e2c514e2so29043327ybf.21
        for <linux-arch@vger.kernel.org>; Mon, 31 Jan 2022 14:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KD03KhdpWtNlFM7oUGmppWdQDaogMVnZhV92Ws+FqAo=;
        b=ia7tC25brH5U3241lA4/ptToWEDhDarYnyLSOw5BRnSjMp98Qa+aFOBXQo/j4/T8Uv
         rkz38N0YYnPnwvVMqrO4dvVLQ4BXIuNMaMshXHtqlbmLrxFogaw17KivHAqr+JWu5gSZ
         HkGMIL9CvfNJrMr6VQAh67kjq+qD6Peyw/92ezZI0//YCCjVM4/KIw9cLUXjC7TIt0nH
         ydfKV9Nh9o3aCywLXYPGfVcBGCc/3d/V+uGk6vag1s/etwSRAua4ESE6NhxrQKI81jeu
         AxUHDrcmuG1kOSNxzi1zlxGvVaxJTeEwdBf2hgrBo9IDl2dHs/UqrK6cXKaQA84NhZ/i
         APng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KD03KhdpWtNlFM7oUGmppWdQDaogMVnZhV92Ws+FqAo=;
        b=4ixnewruWelqZeGVR3tdsJi7vUHtQkwnFHwRED/LLSfsTC1Cjt/9GV5s0h3dANaQnU
         pzT/YIsxyziJYw9Hu7fYKNxucQZLE1gnpq/Kz/q8+ii320O8LJwgKHaD3L9W2bYEekJ+
         Yyw2XiKSdxgWpXXjmiMJFZL8YBuBa/rIAo7Jorz0cAj+dAuvLCPnnlA9PzgbgpOa5e8W
         hYfGsDYMy1mUhQnZzZNml9w3Hdx/XI2ir3Ptov5LMAvMSofCfqe0YkjOhSM8ny7TxJAD
         D8JVbLWhcnzsiaVJhZNJ4OST7f6wGFWh6+yYVpB7iWw4vVVFESqkYDgV8RGGGj4dUXzP
         ZR7w==
X-Gm-Message-State: AOAM532/B7MvR4363+Uf7PqxzmpXNXFDPsgiYDL8d0JgfXUrMchq4z7E
        ZJ55ws45Xk3HlppkLdRrssEabc48IdtyxbBWJ1s=
X-Google-Smtp-Source: ABdhPJy1uQ3LXoiC306CMnAHmkQFpkIxDc5sKYbsBPE2AwjJrdHmWDF+5AeFyVpCFgzmtyUnmUGFua0WeptGMGH4qrE=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:7a1e:ac7e:52e7:5d13])
 (user=ndesaulniers job=sendgmr) by 2002:a25:e803:: with SMTP id
 k3mr33542188ybd.571.1643669584481; Mon, 31 Jan 2022 14:53:04 -0800 (PST)
Date:   Mon, 31 Jan 2022 14:52:47 -0800
Message-Id: <20220131225250.409564-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1643669567; l=2949;
 s=20211004; h=from:subject; bh=T/s3y2AUudBDAwMFE+NSaiKLNbGz5HHO2uafa4nnnfw=;
 b=ukkylGGhYL0nCFFshjIas+H5oTCr9cWOMY9g5B1BgzM1DKPzfcLqmutdMiJ1mmBFmjzQcUY4y2ZU
 jf2LLheWAPUzjbMAWjYga+ugxBZgYobYrch9jxUJkUxb3jgYI5pj
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] docs/memory-barriers.txt: volatile is not a barrier() substitute
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Len Baker <len.baker@gmx.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add text to memory-barriers.txt and deprecated.rst to denote that
volatile-qualifying an asm statement is not a substitute for either a
compiler barrier (``barrier();``) or a clobber list.

This way we can point to this in code that strengthens existing
volatile-qualified asm statements to use a compiler barrier.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Example: https://godbolt.org/z/8PW549zz9

 Documentation/memory-barriers.txt    | 24 ++++++++++++++++++++++++
 Documentation/process/deprecated.rst | 17 +++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b12df9137e1c..f3908c0812da 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1726,6 +1726,30 @@ of optimizations:
      respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
      though the CPU of course need not do so.
 
+ (*) Similarly, the compiler is within its rights to reorder instructions
+     around an asm statement so long as clobbers are not violated. For example,
+
+	asm volatile ("");
+	flag = true;
+
+     May be modified by the compiler to:
+
+	flag = true;
+	asm volatile ("");
+
+     Marking an asm statement as volatile is not a substitute for barrier(),
+     and is implicit for asm goto statements and asm statements that do not
+     have outputs (like the above example). Prefer either:
+
+	asm ("":::"memory");
+	flag = true;
+
+     Or:
+
+	asm ("");
+	barrier();
+	flag = true;
+
  (*) The compiler is within its rights to invent stores to a variable,
      as in the following example:
 
diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 388cb19f5dbb..432816e2f79e 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -329,3 +329,20 @@ struct_size() and flex_array_size() helpers::
         instance->count = count;
 
         memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
+
+Volatile Qualified asm Statements
+=================================
+
+According to `the GCC docs on inline asm
+https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile`_:
+
+  asm statements that have no output operands and asm goto statements,
+  are implicitly volatile.
+
+For many uses of asm statements, that means adding a volatile qualifier won't
+hurt (making the implicit explicit), but it will not strengthen the semantics
+for such cases where it would have been implied. Care should be taken not to
+confuse ``volatile`` with the kernel's ``barrier()`` macro or an explicit
+clobber list. See [memory-barriers]_ for more info on ``barrier()``.
+
+.. [memory-barriers] Documentation/memory-barriers.txt
-- 
2.35.0.rc2.247.g8bbb082509-goog

