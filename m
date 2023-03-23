Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1066C5CDE
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 03:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCWCx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 22:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCWCx0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 22:53:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655DE30197;
        Wed, 22 Mar 2023 19:53:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so601591pjp.1;
        Wed, 22 Mar 2023 19:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679539987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUIti2w3zoA1edKcsXAjpxPn2QEkm+FuO+iswKLAI/g=;
        b=NtZrbvoxKjNgA+xGoQw0VkjOqoUrcYmv0q9yVlg3/j9PS72bUvCUPg3cxt4+qCBISr
         KaDDhlnzGmQQoTlo72ftedHP2nmqpQgcBKBOzf4AonGyQeb5ef5AdQLJd8EO1u1hWeYH
         DTJ2Iw/MID2Qd7YVkv9cNi+Zlhj58jAbYuIllc6eJ6jAzfUdRHXeESv20KHWPdduVDCX
         L0AaNN2TH+5uJwAv+wfJJGa/mhUd+fXyZdFWhmyqHkTk5W0XG4YE1ft2Gd0Rz/fIUwv2
         8u/BXEREPRnTis/YpLX+Y0I1OUDlTRPYhAHpqwEOtAnbBaivgFXfLAD3aMhRikW7sTCb
         PALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679539987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUIti2w3zoA1edKcsXAjpxPn2QEkm+FuO+iswKLAI/g=;
        b=OPgpWW7dn7X90TjLetkmmZ8KDWcNWsNjH3yOdff8P/ghBBggwoDlpa+K95oGfzGQni
         MTvodj+X/B5eA4O7aNC4I2KU47dPzkZJqCfQNXKd/u0JJdqecofOfLwQPAKYYGKY7BXq
         8bHJ4QinD5GesY2lji52FtIL80/SL4Kf5bzbES8VffsnpZmOoN/ZJPDxgS+a+L3NNO1g
         Epuo70mP9qqTTev/oqQX43HjNCdbKbs+DUvULC/a86yORsCAK7sjLzcHUcZe9k1a8mgu
         0CL6+VaqwEdWCXBdTN6+zH2NvJNaujtFqkE8qTIN72VnYUbVH9+Zt/Ontti5zBQWPX06
         72qw==
X-Gm-Message-State: AO0yUKVIffuxcAwGgivong16llkoECr/RR1YbZZpw9amrkUv1tzsoLyV
        SpPuayf+Vof6PlGF6TeQytw=
X-Google-Smtp-Source: AK7set/J8FImsjRQ9ZGziCp1gE2RxxB/o0DKoRZJBu8JTtIKjSnVPP/RCOb87cxvAGVa8roChk2pfw==
X-Received: by 2002:a05:6a20:4b10:b0:da:99f3:4b15 with SMTP id fp16-20020a056a204b1000b000da99f34b15mr1509003pzb.13.1679539987556;
        Wed, 22 Mar 2023 19:53:07 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x3-20020aa793a3000000b005a8851e0cddsm10752459pff.188.2023.03.22.19.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 19:53:07 -0700 (PDT)
Message-ID: <f940cb6c-4aa6-41a4-d9d7-330becd5427a@gmail.com>
Date:   Thu, 23 Mar 2023 11:52:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH memory-model scripts 01/31] tools/memory-model: Document
 locking corner cases
To:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com
Cc:     stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
 <20230321010549.51296-1-paulmck@kernel.org>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230321010549.51296-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On Mon, 20 Mar 2023 18:05:19 -0700, Paul E. McKenney wrote:
> Most Linux-kernel uses of locking are straightforward, but there are
> corner-case uses that rely on less well-known aspects of the lock and
> unlock primitives.  This commit therefore adds a locking.txt and litmus
> tests in Documentation/litmus-tests/locking to explain these corner-case
> uses.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  .../litmus-tests/locking/DCL-broken.litmus    |  55 +++
>  .../litmus-tests/locking/DCL-fixed.litmus     |  56 +++
>  .../litmus-tests/locking/RM-broken.litmus     |  42 +++
>  .../litmus-tests/locking/RM-fixed.litmus      |  42 +++
>  tools/memory-model/Documentation/locking.txt  | 320 ++++++++++++++++++

I think the documentation needs adjustment to cope with Andrea's change
of litmus tests.

Also, coding style of code snippets taken from litmus tests look somewhat
inconsistent with other snippets taken from MP+... litmus tests:

  - Simple function signature such as "void CPU0(void)".
  - No declaration of local variables.
  - Indirection level of global variables.
  - No "locations" clause

How about applying the diff below?

        Thanks, Akira

-----
diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
index 4e05c6d53ab7..65c898c64a93 100644
--- a/tools/memory-model/Documentation/locking.txt
+++ b/tools/memory-model/Documentation/locking.txt
@@ -91,25 +91,21 @@ double-checked locking work correctly,  This litmus test illustrates
 one incorrect approach:
 
 	/* See Documentation/litmus-tests/locking/DCL-broken.litmus. */
-	P0(int *flag, int *data, int *lck)
+	void CPU0(void)
 	{
-		int r0;
-		int r1;
-		int r2;
-
-		r0 = READ_ONCE(*flag);
+		r0 = READ_ONCE(flag);
 		if (r0 == 0) {
-			spin_lock(lck);
-			r1 = READ_ONCE(*flag);
+			spin_lock(&lck);
+			r1 = READ_ONCE(flag);
 			if (r1 == 0) {
-				WRITE_ONCE(*data, 1);
-				WRITE_ONCE(*flag, 1);
+				WRITE_ONCE(data, 1);
+				WRITE_ONCE(flag, 1);
 			}
-			spin_unlock(lck);
+			spin_unlock(&lck);
 		}
-		r2 = READ_ONCE(*data);
+		r2 = READ_ONCE(data);
 	}
-	/* P1() is the exactly the same as P0(). */
+	/* CPU1() is the exactly the same as CPU0(). */
 
 There are two problems.  First, there is no ordering between the first
 READ_ONCE() of "flag" and the READ_ONCE() of "data".  Second, there is
@@ -120,25 +116,21 @@ One way to fix this is to use smp_load_acquire() and smp_store_release()
 as shown in this corrected version:
 
 	/* See Documentation/litmus-tests/locking/DCL-fixed.litmus. */
-	P0(int *flag, int *data, int *lck)
+	void CPU0(void)
 	{
-		int r0;
-		int r1;
-		int r2;
-
-		r0 = smp_load_acquire(flag);
+		r0 = smp_load_acquire(&flag);
 		if (r0 == 0) {
-			spin_lock(lck);
-			r1 = READ_ONCE(*flag);
+			spin_lock(&lck);
+			r1 = READ_ONCE(flag);
 			if (r1 == 0) {
-				WRITE_ONCE(*data, 1);
-				smp_store_release(flag, 1);
+				WRITE_ONCE(data, 1);
+				smp_store_release(&flag, 1);
 			}
-			spin_unlock(lck);
+			spin_unlock(&lck);
 		}
-		r2 = READ_ONCE(*data);
+		r2 = READ_ONCE(data);
 	}
-	/* P1() is the exactly the same as P0(). */
+	/* CPU1() is the exactly the same as CPU0(). */
 
 The smp_load_acquire() guarantees that its load from "flags" will
 be ordered before the READ_ONCE() from data, thus solving the first
@@ -238,81 +230,67 @@ loads, with a "filter" clause to constrain the first to return the
 initial value and the second to return the updated value, as shown below:
 
 	/* See Documentation/litmus-tests/locking/RM-fixed.litmus. */
-	P0(int *x, int *y, int *lck)
+	void CPU0(void)
 	{
-		int r2;
-
-		spin_lock(lck);
-		r2 = atomic_inc_return(y);
-		WRITE_ONCE(*x, 1);
-		spin_unlock(lck);
+		spin_lock(&lck);
+		r2 = atomic_inc_return(&y);
+		WRITE_ONCE(x, 1);
+		spin_unlock(&lck);
 	}
 
-	P1(int *x, int *y, int *lck)
+	void CPU1(void)
 	{
-		int r0;
-		int r1;
-		int r2;
-
-		r0 = READ_ONCE(*x);
-		r1 = READ_ONCE(*x);
-		spin_lock(lck);
-		r2 = atomic_inc_return(y);
-		spin_unlock(lck);
+		r0 = READ_ONCE(x);
+		r1 = READ_ONCE(x);
+		spin_lock(&lck);
+		r2 = atomic_inc_return(&y);
+		spin_unlock(&lck);
 	}
 
-	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+	filter (1:r0=0 /\ 1:r1=1)
 	exists (1:r2=1)
 
 The variable "x" is the control variable for the emulated spin loop.
-P0() sets it to "1" while holding the lock, and P1() emulates the
+CPU0() sets it to "1" while holding the lock, and CPU1() emulates the
 spin loop by reading it twice, first into "1:r0" (which should get the
 initial value "0") and then into "1:r1" (which should get the updated
 value "1").
 
-The purpose of the variable "y" is to reject deadlocked executions.
-Only those executions where the final value of "y" have avoided deadlock.
+The "filter" clause takes this into account, constraining "1:r0" to
+equal "0" and "1:r1" to equal 1.
 
-The "filter" clause takes all this into account, constraining "y" to
-equal "2", "1:r0" to equal "0", and "1:r1" to equal 1.
-
-Then the "exists" clause checks to see if P1() acquired its lock first,
-which should not happen given the filter clause because P0() updates
+Then the "exists" clause checks to see if CPU1() acquired its lock first,
+which should not happen given the filter clause because CPU0() updates
 "x" while holding the lock.  And herd7 confirms this.
 
 But suppose that the compiler was permitted to reorder the spin loop
-into P1()'s critical section, like this:
+into CPU1()'s critical section, like this:
 
 	/* See Documentation/litmus-tests/locking/RM-broken.litmus. */
-	P0(int *x, int *y, int *lck)
+	void CPU0(void)
 	{
 		int r2;
 
-		spin_lock(lck);
-		r2 = atomic_inc_return(y);
-		WRITE_ONCE(*x, 1);
-		spin_unlock(lck);
+		spin_lock(&lck);
+		r2 = atomic_inc_return(&y);
+		WRITE_ONCE(x, 1);
+		spin_unlock(&lck);
 	}
 
-	P1(int *x, int *y, int *lck)
+	void CPU1(void)
 	{
-		int r0;
-		int r1;
-		int r2;
-
-		spin_lock(lck);
-		r0 = READ_ONCE(*x);
-		r1 = READ_ONCE(*x);
-		r2 = atomic_inc_return(y);
-		spin_unlock(lck);
+		spin_lock(&lck);
+		r0 = READ_ONCE(x);
+		r1 = READ_ONCE(x);
+		r2 = atomic_inc_return(&y);
+		spin_unlock(&lck);
 	}
 
-	locations [x;lck;0:r2;1:r0;1:r1;1:r2]
-	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+	filter (1:r0=0 /\ 1:r1=1)
 	exists (1:r2=1)
 
-If "1:r0" is equal to "0", "1:r1" can never equal "1" because P0()
-cannot update "x" while P1() holds the lock.  And herd7 confirms this,
+If "1:r0" is equal to "0", "1:r1" can never equal "1" because CPU0()
+cannot update "x" while CPU1() holds the lock.  And herd7 confirms this,
 showing zero executions matching the "filter" criteria.
 
 And this is why Linux-kernel lock and unlock primitives must prevent



