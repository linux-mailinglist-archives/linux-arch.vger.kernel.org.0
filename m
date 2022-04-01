Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90BF4EE82C
	for <lists+linux-arch@lfdr.de>; Fri,  1 Apr 2022 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbiDAG2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Apr 2022 02:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiDAG2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2022 02:28:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4725FD5E;
        Thu, 31 Mar 2022 23:26:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso4472621pju.1;
        Thu, 31 Mar 2022 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9fHQZIB7lEOQ68Fiz/ieQBcf4TMZ/QdfUXApZz8NUgg=;
        b=UaOznirKfKonKligOllW8vnuEJEkeWhR8CChTAZkggFNqGQNi+ZC0uoM49LZao7Rnz
         doLKhS6BlQ5WQjPaoZyg/nDIfWBMFkTs9Zq45/mxpV5iuuIfWysCTpgRFhF864DBAxuC
         h6FoLmeKKhqNn3f5OrfKVoQMzWFy8NHdv+A8s94XRDB/nnL3utZAjQ2X6Qn7PemQLJkO
         mFYA2pEarcqnrlhfuapxMyM3HddPEhDsoe8itQ43axG6QV+HLsGDTrOENeCXwoLJO5Qy
         1fXNyLo5m1D17QaGhWNFYC/sPQsAAcRWP+K6jBUurtAahyShIF2L85kFtg04R6kOOyp6
         d4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9fHQZIB7lEOQ68Fiz/ieQBcf4TMZ/QdfUXApZz8NUgg=;
        b=hfHlXysmtPgPnrQd+2amPjSHxFa1w1uKfegAggCVCVNHHbiiIFqMDf8MzrVJKxO1Tz
         G3eo4vHrl+aLyLyBg3JbdaabFHH1YxRovWLngtsuw7k1njdxRpmTiuwMJWoD6BOZXBZu
         4w9QZD+EPFIUQCskGqWpaFHcwk01NaYffQUqkcku+ixuQ7+UA450PMyPYvuQrnoZLnLM
         sXL2TXrRaIN4PVpcNyL+IFH7caodInZTUnvEuwL9pLyAk5SxLZZNq2Skj5ZIvnVMv+Rx
         yzB5h7MXjBH6oGbtdjrmD0mhRpXrtLlPnycNZ4VlA0w2yH3OyaLCYgAsLWNcxEJA8FZZ
         yPQA==
X-Gm-Message-State: AOAM530zqzERMAy2ymHB1O6xFzJwaJjh7pCIMQJRGP9qbLv+pzrrIVV4
        DKXgBEU9ygKWrJ8NcNEOD4E=
X-Google-Smtp-Source: ABdhPJyj0tuiwEwJ+qROZpwB/NOzj5QftX/nkjRseN6sPLBWpd2GqEKAPDS45dsfrkZq0craCACJxw==
X-Received: by 2002:a17:90a:c28c:b0:1c9:9eef:6e2b with SMTP id f12-20020a17090ac28c00b001c99eef6e2bmr10043854pjt.188.1648794386131;
        Thu, 31 Mar 2022 23:26:26 -0700 (PDT)
Received: from google.com ([2601:647:4800:3540:4583:f18f:adab:79b7])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm1578335pfu.202.2022.03.31.23.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 23:26:25 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 31 Mar 2022 23:26:17 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <YkabCQYJmq9G9ZJ4@google.com>
References: <20220322185709.141236-1-namhyung@kernel.org>
 <20220322185709.141236-3-namhyung@kernel.org>
 <20220328113946.GA8939@worktop.programming.kicks-ass.net>
 <CAM9d7ciQQEypvv2a2zQLHNc7p3NNxF59kASxHoFMCqiQicKwBA@mail.gmail.com>
 <20220330110853.GK8939@worktop.programming.kicks-ass.net>
 <CAM9d7cjQnThKgsUfnqJDcmBFseSTk-56a6f0sefo1x8D7LWSZw@mail.gmail.com>
 <20220331115916.GU8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331115916.GU8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 31, 2022 at 01:59:16PM +0200, Peter Zijlstra wrote:
> I've since pushed out the lot to:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> 
> It builds, but I've not actually used it. Much appreciated if you could
> test.
> 

I've tested it and it worked well.  Thanks for your work!

And we need to add the below too..

Thanks,
Namhyung

----8<----

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index db5bdbb9b9c0..9463a93132c3 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -114,7 +114,8 @@ TRACE_EVENT(contention_begin,
 				{ LCB_F_READ,		"READ" },
 				{ LCB_F_WRITE,		"WRITE" },
 				{ LCB_F_RT,		"RT" },
-				{ LCB_F_PERCPU,		"PERCPU" }
+				{ LCB_F_PERCPU,		"PERCPU" },
+				{ LCB_F_MUTEX,		"MUTEX" }
 			  ))
 );
 
