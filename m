Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0E694434
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 12:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBMLQA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 06:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjBMLP6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 06:15:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0A199D0;
        Mon, 13 Feb 2023 03:15:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z13so8446122wmp.2;
        Mon, 13 Feb 2023 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U97JWXqi1StumDff2f9VyDMu5Xn1n9829sI3DxVJ5HQ=;
        b=H8GxlqYckQkUbXmNepI6CEAfvHnK8tZPmwsg24djiCW7a8rP3kf0ABVTbeLz7gqZQ0
         DGh4QAQ9izHxssN35TBJUIu5/gilSashG9G1jg890weWvhDDo5G0kQ3Jot23bhL9yRN9
         WIH77lgNIMe9+Mp4os9CtYgMv84lvnopGuVriaDVorhHafeuiD2sGvWDg4B5WVhXNcBB
         ZOnw69WxHYtyVvCaFf4zraK/0xJI9RTS8KoqxxVACJ8S3j/zOz7GLCQ07WYXsQbIYFza
         bWz8UnW0MNE8Erz/ZpfDPKAhr4F5D5fpEQAMyznjIGQE0PsXm2bJ6MIOYPkBW8rDxNum
         VJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U97JWXqi1StumDff2f9VyDMu5Xn1n9829sI3DxVJ5HQ=;
        b=dSGpwi0tgHtNfWwsL2ylnN1MWeLbWNCGWn20dNI4CN3ys9Xx42tCdc90PXiVgiE1ua
         6tRpyFctFs2i/eEN4aFlLa/9NSWsHwyfFuFaujCU62rEfpWxtg+QuGUuA3ppNMMY4+R2
         O793b9ziMs+uLRhLm1mEpSkTva7izZGldA6Vmp4rOen3RZodoEyLj/E2i1Bie69ncFMd
         6iBuCg0HFhHFTEO27NLxIu8L+Qtn8e89DCQwdJoVkWd1h/Ej6bedna+4YSjt0gFEQeXs
         DOCPW4UoSB9Np1wc58X+pYm4qxi2IWJs93kUf13W5a7PwU4WL9McF8prJ1GGvViA5Q2R
         uMLA==
X-Gm-Message-State: AO0yUKUs6xAAfd1djMSdFarf0xKO/55F2NjEcQGF9iYEWdde3VxZ4H2q
        eX4JO9ymi9WcZ2AvEdzUVGGKCMbDrTiP6ixI
X-Google-Smtp-Source: AK7set+wEqHeUX27CNwuZ6TDHzo1S9Xj/xG44P5Oeg1IKP8BPhgdwKe5jyDnjQvB3wjHaTzvZQiKwA==
X-Received: by 2002:a05:600c:810:b0:3de:25f2:3aee with SMTP id k16-20020a05600c081000b003de25f23aeemr20323959wmp.31.1676286938615;
        Mon, 13 Feb 2023 03:15:38 -0800 (PST)
Received: from andrea ([84.242.162.60])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b003e11ad0750csm12873275wmo.47.2023.02.13.03.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:15:38 -0800 (PST)
Date:   Mon, 13 Feb 2023 12:15:31 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+ob0xFUp+d7LROE@andrea>
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
 <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
 <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > Would you like to post a few examples showing some of the most difficult
> > points you encountered?  Maybe explanation.txt can be improved.
> 
> Just to list 2 of the pain points:
> 
> 1. I think it is hard to reason this section
> "PROPAGATION ORDER RELATION: cumul-fence"
> 
> All store-related fences should affect propagation order, even the
> smp_wmb() which is not A-cumulative should do so (po-earlier stores
> appearing before po-later). I think expanding this section with some
> examples would make sense to understand what makes "cumul-fence"
> different from any other store-related fence.

FWIW, litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus illustrates
the concept of A-cumulativity.  (The terminology is not LKMM-specific, it was
borrowed from other MCM literature, e.g. "Understanding POWER Multiprocessors"
in Documentation/references.txt.)


> 2. This part is confusing and has always confused me " The
> happens-before relation (hb) links memory accesses that have to
> execute in a certain order"
> 
> It is not memory accesses that execute, it is instructions that
> execute. Can we separate out "memory access" from "instruction
> execution" in this description?
> 
> I think ->hb tries to say that A ->hb B means, memory access A
> happened before memory access B exactly in its associated
> instruction's execution order (time order), but to be specific --
> should that be instruction issue order, or instruction retiring order?
> 
> AFAICS ->hb maps instruction execution order to memory access order.
> Not all ->po does  fall into that category because of out-of-order
> hardware execution. As does not ->co because the memory subsystem may
> have writes to the same variable to be resolved out of order. It would
> be nice to call out that ->po is instruction issue order, which is
> different from execution/retiring and that's why it cannot be ->hb.
> 
> ->rf does because of data flow causality, ->ppo does because of
> program structure, so that makes sense to be ->hb.
> 
> IMHO, ->rfi should as well, because it is embodying a flow of data, so
> that is a bit confusing. It would be great to clarify more perhaps
> with an example about why ->rfi cannot be ->hb, in the
> "happens-before" section.
> 
> That's really how far I typically get (line 1368) before life takes
> over, and I have to go do other survival-related things. Then I
> restart the activity. Now that I started reading the CAT file as well,
> I feel I can make it past that line :D. But I never wanted to get past
> it, till I built a solid understanding of the contents before it.
> 
> As I read the file more, I can give more feedback, but the above are
> different 2 that persist.

AFAICT, sections "The happens-before relation: hb" and "An operational model"
in Documentation/explanation.txt elaborate (should help) clarify such issues.
About the ->rfi example cf. e.g. Test PPOCA in the above mentioned paper; the
test remains allowed in arm64 and riscv.

  Andrea
