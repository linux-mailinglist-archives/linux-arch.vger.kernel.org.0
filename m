Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784AA6C457C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 09:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCVI7r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 04:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVI7q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 04:59:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D84AFE7;
        Wed, 22 Mar 2023 01:59:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ew6so6798246edb.7;
        Wed, 22 Mar 2023 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679475583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fMZAhNKxBafShWjvkXP8mjAoJFEZrRyPKGSB67IZ/W0=;
        b=pMSH/splwrSv6wUN6+i3TwO4YKPv7JdL9hDPQMaYG5sM5Ew87ocbSH13Zl0fbrAZqn
         4d5BhHkup6u+kzjEEBzFon2wzhVEVkZN8eJ2Jx50b60Cr+3xxU6rsgVKuoGDix8zxJ5O
         H1OQHJa0FhVmuPdkQDLf/H2DtAlXHh47w4gmyHgCtSDhLaMxZHrOraZIYBjfuewL0rfD
         r86qFgDR5Ax356p8B9Fz+gMBMFnGhSrEVQuwER2Vg8ahOb+jm6IpEYuzgLdN+zCQTwjZ
         HpDz1v1JGW263Y54jiyFKnQkcySFJPC/uyc04zNXZNhHcsECutr1fs7yDyKWIgxl75TQ
         C/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679475583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMZAhNKxBafShWjvkXP8mjAoJFEZrRyPKGSB67IZ/W0=;
        b=tORwcq7YeqYKkBiIuZLn/cqgw/lpF6D6hGVDIdO4zzX6OFlp4KNZ756HJe3zvSd8GI
         tF9ucmhqiod5Ucy3BDE9uslhOtOOTQQYmnpPWPbyPI7lZxGMSL0D86dM2scTHTQkcPam
         tAbCv9u7X9M8f4A0dyKR8WxUkuUOkj2RaFZwOPYryo9VvWK2sdCw79XP/hF19u+Uw1SS
         UQZKyRCjHPqKrxLjWpJi8IVmXqvB27CkHbK2mLscNoS2P1vsI7NK3Dcq9rjPnKIOlr4O
         j6IEsw3H7y91Mj+APwAG0wDl8ui3EsA0ojSQySMs0xXWYl1UfkBGHyMzTFHg0nz7uw9f
         pqvg==
X-Gm-Message-State: AO0yUKWEwBaMdPLoKJfMouc1twnYor4b9sTZuSFWoqL0nu/UdCF7aL/5
        kHrmcCOWj+TLOSvU1VPxoBsJpjnwcFj3lx6j
X-Google-Smtp-Source: AK7set9Urn7PFBX1x9P+a/1n9aK7bGYS/XxjM4AtTKEWqA9Gk5aLosso8dBHHTcdixT45+1epb9bxg==
X-Received: by 2002:a17:906:2e8e:b0:933:44ef:e5b5 with SMTP id o14-20020a1709062e8e00b0093344efe5b5mr6944534eji.30.1679475583472;
        Wed, 22 Mar 2023 01:59:43 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id u25-20020a50c2d9000000b004faf34064c8sm7294180edf.62.2023.03.22.01.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:59:43 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:59:38 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model scripts 01/31] tools/memory-model:  Document
 locking corner cases
Message-ID: <ZBrDeoCIs1wmNBeF@andrea>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
 <20230321010549.51296-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321010549.51296-1-paulmck@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>  create mode 100644 Documentation/litmus-tests/locking/DCL-broken.litmus
>  create mode 100644 Documentation/litmus-tests/locking/DCL-fixed.litmus
>  create mode 100644 Documentation/litmus-tests/locking/RM-broken.litmus
>  create mode 100644 Documentation/litmus-tests/locking/RM-fixed.litmus

Unfortunately none of them were liked by klitmus7/gcc, the diff below
works for me but please double check.

  Andrea


diff --git a/Documentation/litmus-tests/locking/DCL-broken.litmus b/Documentation/litmus-tests/locking/DCL-broken.litmus
index cfaa25ff82b1e..bfb7ba4316d69 100644
--- a/Documentation/litmus-tests/locking/DCL-broken.litmus
+++ b/Documentation/litmus-tests/locking/DCL-broken.litmus
@@ -10,10 +10,9 @@ C DCL-broken
 {
 	int flag;
 	int data;
-	int lck;
 }
 
-P0(int *flag, int *data, int *lck)
+P0(int *flag, int *data, spinlock_t *lck)
 {
 	int r0;
 	int r1;
@@ -32,7 +31,7 @@ P0(int *flag, int *data, int *lck)
 	r2 = READ_ONCE(*data);
 }
 
-P1(int *flag, int *data, int *lck)
+P1(int *flag, int *data, spinlock_t *lck)
 {
 	int r0;
 	int r1;
@@ -51,5 +50,5 @@ P1(int *flag, int *data, int *lck)
 	r2 = READ_ONCE(*data);
 }
 
-locations [flag;data;lck;0:r0;0:r1;1:r0;1:r1]
+locations [flag;data;0:r0;0:r1;1:r0;1:r1]
 exists (0:r2=0 \/ 1:r2=0)
diff --git a/Documentation/litmus-tests/locking/DCL-fixed.litmus b/Documentation/litmus-tests/locking/DCL-fixed.litmus
index 579d6c246f167..d1b60bcb0c8f3 100644
--- a/Documentation/litmus-tests/locking/DCL-fixed.litmus
+++ b/Documentation/litmus-tests/locking/DCL-fixed.litmus
@@ -11,10 +11,9 @@ C DCL-fixed
 {
 	int flag;
 	int data;
-	int lck;
 }
 
-P0(int *flag, int *data, int *lck)
+P0(int *flag, int *data, spinlock_t *lck)
 {
 	int r0;
 	int r1;
@@ -33,7 +32,7 @@ P0(int *flag, int *data, int *lck)
 	r2 = READ_ONCE(*data);
 }
 
-P1(int *flag, int *data, int *lck)
+P1(int *flag, int *data, spinlock_t *lck)
 {
 	int r0;
 	int r1;
@@ -52,5 +51,5 @@ P1(int *flag, int *data, int *lck)
 	r2 = READ_ONCE(*data);
 }
 
-locations [flag;data;lck;0:r0;0:r1;1:r0;1:r1]
+locations [flag;data;0:r0;0:r1;1:r0;1:r1]
 exists (0:r2=0 \/ 1:r2=0)
diff --git a/Documentation/litmus-tests/locking/RM-broken.litmus b/Documentation/litmus-tests/locking/RM-broken.litmus
index c586ae4b547de..b7ef30cedfe51 100644
--- a/Documentation/litmus-tests/locking/RM-broken.litmus
+++ b/Documentation/litmus-tests/locking/RM-broken.litmus
@@ -9,12 +9,11 @@ C RM-broken
  *)
 
 {
-	int lck;
 	int x;
-	int y;
+	atomic_t y;
 }
 
-P0(int *x, int *y, int *lck)
+P0(int *x, atomic_t *y, spinlock_t *lck)
 {
 	int r2;
 
@@ -24,7 +23,7 @@ P0(int *x, int *y, int *lck)
 	spin_unlock(lck);
 }
 
-P1(int *x, int *y, int *lck)
+P1(int *x, atomic_t *y, spinlock_t *lck)
 {
 	int r0;
 	int r1;
@@ -37,6 +36,6 @@ P1(int *x, int *y, int *lck)
 	spin_unlock(lck);
 }
 
-locations [x;lck;0:r2;1:r0;1:r1;1:r2]
-filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+locations [x;0:r2;1:r0;1:r1;1:r2]
+filter (1:r0=0 /\ 1:r1=1)
 exists (1:r2=1)
diff --git a/Documentation/litmus-tests/locking/RM-fixed.litmus b/Documentation/litmus-tests/locking/RM-fixed.litmus
index 672856736b42e..b628175596160 100644
--- a/Documentation/litmus-tests/locking/RM-fixed.litmus
+++ b/Documentation/litmus-tests/locking/RM-fixed.litmus
@@ -9,12 +9,11 @@ C RM-fixed
  *)
 
 {
-	int lck;
 	int x;
-	int y;
+	atomic_t y;
 }
 
-P0(int *x, int *y, int *lck)
+P0(int *x, atomic_t *y, spinlock_t *lck)
 {
 	int r2;
 
@@ -24,7 +23,7 @@ P0(int *x, int *y, int *lck)
 	spin_unlock(lck);
 }
 
-P1(int *x, int *y, int *lck)
+P1(int *x, atomic_t *y, spinlock_t *lck)
 {
 	int r0;
 	int r1;
@@ -37,6 +36,6 @@ P1(int *x, int *y, int *lck)
 	spin_unlock(lck);
 }
 
-locations [x;lck;0:r2;1:r0;1:r1;1:r2]
-filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+locations [x;0:r2;1:r0;1:r1;1:r2]
+filter (1:r0=0 /\ 1:r1=1)
 exists (1:r2=1)
