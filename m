Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED375A4117
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 04:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiH2Cdb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Aug 2022 22:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2Cdb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Aug 2022 22:33:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF39630F6D;
        Sun, 28 Aug 2022 19:33:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb36so12986541ejc.10;
        Sun, 28 Aug 2022 19:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=L51GDzPSG19BfJI114hwBB3IlYH+VcFb/yVVpkhA/C0=;
        b=ly+BJ+KVFpL+n5YzFS01gEAHFL6WgRg35f6oW2wkxW6uXnx09LaB9uj4AX8+PzRJsv
         O903MaDO1aAGhzIflMg6+W4xBWakprYZ9koGcGsWmkCcLGCQBFWHidSnb72UJaCJMp/t
         QexAj/9737cNalhQ0Sr70OYu3G05/VMZumDanYkr+3LNLZZaxM6F/p0P4JMf8pt8OF3Q
         WSYZLVK7T+hcg2Td82MCAdWbRe7ZIjwk0DhUi5csmUZJzbCVlNXerSFncKYdI1crnvHf
         kYWqpJq8f+TaP749QtlKMf29mOBVbzrnA27O9DIdmIew7QMuV1EZ/LevbfrCDPMgq8b6
         +l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=L51GDzPSG19BfJI114hwBB3IlYH+VcFb/yVVpkhA/C0=;
        b=m+a4Oar0ZWMwtUuaZl3veExP9ItntBW9Vvbm5dpAk9NG1Q0gMVy+2JB2ZST+qwNgN2
         RCZeVxICswisJDmznnfPV8cQQ/SRHsSvLKR/7VPRuMMkpjLn1HcWqFWb8fQtzOTibfro
         RlmH3u+THCNaaCjweR3+gVfaHT25Vr4MUvfKpQjAzD9yCIOyZLtRJdOWq2yGCVuSdDjT
         f1K5Xt/ZGYnEiuqwg2ZKR9Cw3GmagO0PQEeRyX2o1A6vii1AUTy7CXcVQbDTHi/BRZHG
         xJAsDPYqCfH919w12o7ueyuTVNeGbUcao+6v/b1HZgR3gPye7H8B8DocqITmnafJDitn
         INoQ==
X-Gm-Message-State: ACgBeo2Q6ddKVlYi6BdurVYRetw0gGvYtfkUKDyofPnl0m+rbPNmdhzy
        FUU4QQKmfiM6nELKcut3OAQ=
X-Google-Smtp-Source: AA6agR6zBuDXPoBxRNjxcvNcQ7cU+mpyItWPhRyi2L/lhYPpVNVMcBpzfkqhDonH4hJPEq16OguBJw==
X-Received: by 2002:a17:906:3a15:b0:73d:80bf:542c with SMTP id z21-20020a1709063a1500b0073d80bf542cmr12215431eje.633.1661740408294;
        Sun, 28 Aug 2022 19:33:28 -0700 (PDT)
Received: from anparri (host-95-238-28-128.retail.telecomitalia.it. [95.238.28.128])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906781500b0072f42ca292bsm3824851ejm.129.2022.08.28.19.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 19:33:27 -0700 (PDT)
Date:   Mon, 29 Aug 2022 04:33:23 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YwwlWMmHxD7OPERD@anparri>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 05:48:12AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> I have not yet done more than glance at this one, but figured I should
> send it along sooner rather than later.
> 
> "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
> Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
> Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
> https://arxiv.org/abs/2111.15240
> 
> The claim is that the queued spinlocks implementation with CNA violates
> LKMM but actually works on all architectures having a formal hardware
> memory model.
> 
> Thoughts?

Section 4 ends with a discussion about certain "spurious" data races.
Do we have litmus tests with them?  (I could repro with Dartagnan...)

Thanks,
  Andrea
