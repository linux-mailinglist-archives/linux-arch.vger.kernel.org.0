Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1115A4100
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 04:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiH2CPu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Aug 2022 22:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2CPu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Aug 2022 22:15:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4BD20BD6;
        Sun, 28 Aug 2022 19:15:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lx1so12928415ejb.12;
        Sun, 28 Aug 2022 19:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=EIPwhjUv8h30K8Ui8w76NDyV5Lb0v5YJ4+waiGfUYPw=;
        b=lrj39VVqxYQ3QhQecMZQznjhs1P9Sxae833V9b8ccarwRRnN4GZ85/Uy++/hbRM/AI
         S5ZUWnd0+WHsYGn5zB7XfuWi85v5AGvjOTefUCTglvecUNH/O/esNPs7ZoW9nnZES++8
         JnwDHtdYJYQ5gWwUpCdKFUQ2VKNHGA1fudyqErhkOBcjID6kTjCXKQN0pCCcZ3WCN77/
         FynJZOC2DixFConIBgttZKC+XcX5GiMhb8OA4pHFgOWXoM3dFhxvfKkZfgFYkHegULOd
         twR6vc7cxWXeLz+CgHC4rsdgufvKpLzoUxCoy7t65KpBCr9+v9EqBd2vtQJ539+9Cse1
         Jyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EIPwhjUv8h30K8Ui8w76NDyV5Lb0v5YJ4+waiGfUYPw=;
        b=hZX4Iyvh67PleJmOE3YQZ1XOIOeB1L9DcRv3r0T5f1EuxdDnysV2b4D89oJ5x5M/Uv
         tFiXMZ593M3qSerB9gdToyLKNqoc/3yca2ciWVtFRmzy2UsQKk2C0XTnDGHHGmAtaQ9T
         +wX9Mj1VQZ0MgivzBwxcvrxgHEn58EbCXt4hqc30LTgv2uDkgoNjGhHYnPa+pw7NynCi
         iZASfQ+OmYm5yJMlB5fxCs4ZlsxQ4Mk5YrlAreB/ACWJFQf3sBiH7EXca6h2ByDweFHy
         ThaR3Rn3TaTMSk8fcTrL354enKdF93r47lyJ6kWD9YTqYLq3Ceh4fmxyBA0KhXTyR8uB
         jFrA==
X-Gm-Message-State: ACgBeo31+1YUKjgAdAhpzRvsXx0IT+FA8h7lUke8WFV/rgoTIdNuxh9I
        Y+FbbtKobqV/qXFvLDTrymk=
X-Google-Smtp-Source: AA6agR7tMQVy6YI+ggn4+GffgrFazqfTH/PEdWMK5FMxPLUod5/1IRNyQy3jgj42r5K7TpNiq77Yhg==
X-Received: by 2002:a17:907:60c7:b0:731:17e4:7fcc with SMTP id hv7-20020a17090760c700b0073117e47fccmr12058833ejc.73.1661739347185;
        Sun, 28 Aug 2022 19:15:47 -0700 (PDT)
Received: from anparri (host-95-238-28-128.retail.telecomitalia.it. [95.238.28.128])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7c504000000b004485afde654sm1867806edq.6.2022.08.28.19.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 19:15:46 -0700 (PDT)
Date:   Mon, 29 Aug 2022 04:15:42 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YwwhG8bzsKlJ2eEY@anparri>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
 <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> FWIW, C++ defines this as (in https://eel.is/c++draft/atomics#order-11):
> 
> 	Implementations should make atomic stores visible to atomic
> 	loads within a reasonable amount of time.
> 
> in other words:
> 
> if one thread does an atomic store, then all other threads must see that
> store eventually.
> 
> (from: https://rust-lang.zulipchat.com/#narrow/stream/136281-t-lang.2Fwg-unsafe-code-guidelines/topic/Rust.20forward.20progress.20guarantees/near/294702950)
> 
> Should we add something somewhere in our model, maybe in the
> explanation.txt?

FYI, that's briefly mentioned in Section 11, "CACHE COHERENCE AND THE
COHERENCE ORDER RELATION: co, coi, and coe":

  "sequential consistency per variable and cache coherence mean the
   same thing except that cache coherence includes an extra requirement
   that every store eventually becomes visible to every CPU"

  Andrea


> Plus, I think we cannot express this in Herd because Herd uses
> graph-based model (axiomatic model) instead of an operational model to
> describe the model: axiomatic model cannot describe "something will
> eventually happen". There was also some discussion in the zulip steam
> of Rust unsafe-code-guidelines.
