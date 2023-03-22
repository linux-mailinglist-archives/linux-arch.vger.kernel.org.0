Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC16C3FEB
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 02:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCVBk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 21:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCVBk6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 21:40:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5745B1706;
        Tue, 21 Mar 2023 18:40:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so66959081edb.11;
        Tue, 21 Mar 2023 18:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679449256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDtrmWxNd7ykAwuZ6ssL1W5nZI+T6l4E7ASY8mvq1C4=;
        b=dtcVIdQQd5o2rj21d/O6qOLOgwcZ7cOTnPmZ4pSwGSXjkhhn7L6oueiwaUosDJ/XlT
         GnK1SmsgoNqmRmJm9jDmK9A1/eaCOE3P9Y56z7M+49lf6hCTHzlklXp/oWx8BEE5fzog
         rUIOGcQUVrlEySP7xRRdLF3O7OEz36v6eDpwBMAAnkwjxmGl3sm6kPXpSM72BSjoGcmc
         br9FirMAREgvewJxwqav1kG+HnY5BSthW8WuzOUs5Zm/gggCL4iCbGs6jnc/nCp6pXVS
         8Tgb+Oc5wiWADfGJ3iP5BYAqN3OP/KUkdqyxSMBCFqfWpweIvWIoM8BYDDjvXjadQO7U
         kEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679449256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDtrmWxNd7ykAwuZ6ssL1W5nZI+T6l4E7ASY8mvq1C4=;
        b=Fwc8dkQ/xtDAr1ycPHRq1zcOpVNfb8LaP+Y/Swr04w6ie55ofqmgx7LrvLwLXee9+U
         8OzJT7iWxaEpII7/VqOFBchedzmGN7/xM7cqzyW+G71taRVD5ZrV03zqdzvEHz0h9v0X
         BFLYBl4EA9SC8HAjsl/OzzBBpuKQzTaad5MkBJAjeprNmqST1nYFO4MVWMHOAVlIEnu6
         BZgEDi6VoN0f8xjSyp60BeeuHYzlPEhOFBtzzaeKTJhg2TkQmQXB1LRY9gVjcFltDRrJ
         9LYkYIOpJbO3K/Jl0EqaesLbnKjD37iTjB18usoHzvGuRCUHvm6q+jsO1IA0dme6bAqX
         5ccQ==
X-Gm-Message-State: AO0yUKVSHqGcHlVqYvIdaK5iQ7Izg9fzT7tk9gtlfiPUTBMikd9uyALh
        vIRAC9EUuxBr0HjamnRsapU=
X-Google-Smtp-Source: AK7set/whfUVSSRR5XI6XndbcgMiiEtOrkr2bD31H4seY4K3NVknej4zpiVCtQa+lj9EcZCVvEuTEw==
X-Received: by 2002:a17:906:60c9:b0:931:b2ae:116e with SMTP id f9-20020a17090660c900b00931b2ae116emr4637734ejk.64.1679449255431;
        Tue, 21 Mar 2023 18:40:55 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm6568091eja.95.2023.03.21.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:40:54 -0700 (PDT)
Date:   Wed, 22 Mar 2023 02:40:52 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH memory-model 7/8] tools/memory-model: Add documentation
 about SRCU read-side critical sections
Message-ID: <ZBpcpPIq9k2mX7cw@andrea>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-7-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321010246.50960-7-paulmck@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 20, 2023 at 06:02:45PM -0700, Paul E. McKenney wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Expand the discussion of SRCU and its read-side critical sections in
> the Linux Kernel Memory Model documentation file explanation.txt.  The
> new material discusses recent changes to the memory model made in
> commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU
> semantics").

How about squashing the diff below (adjusting subject and changelog):

  Andrea

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 26554b1c5575e..acac527328a1f 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -1028,32 +1028,7 @@ Limitations of the Linux-kernel memory model (LKMM) include:
 		additional call_rcu() process to the site of the
 		emulated rcu-barrier().
 
-	e.	Although sleepable RCU (SRCU) is now modeled, there
-		are some subtle differences between its semantics and
-		those in the Linux kernel.  For example, the kernel
-		might interpret the following sequence as two partially
-		overlapping SRCU read-side critical sections:
-
-			 1  r1 = srcu_read_lock(&my_srcu);
-			 2  do_something_1();
-			 3  r2 = srcu_read_lock(&my_srcu);
-			 4  do_something_2();
-			 5  srcu_read_unlock(&my_srcu, r1);
-			 6  do_something_3();
-			 7  srcu_read_unlock(&my_srcu, r2);
-
-		In contrast, LKMM will interpret this as a nested pair of
-		SRCU read-side critical sections, with the outer critical
-		section spanning lines 1-7 and the inner critical section
-		spanning lines 3-5.
-
-		This difference would be more of a concern had anyone
-		identified a reasonable use case for partially overlapping
-		SRCU read-side critical sections.  For more information
-		on the trickiness of such overlapping, please see:
-		https://paulmck.livejournal.com/40593.html
-
-	f.	Reader-writer locking is not modeled.  It can be
+	e.	Reader-writer locking is not modeled.  It can be
 		emulated in litmus tests using atomic read-modify-write
 		operations.
 

  Andrea
