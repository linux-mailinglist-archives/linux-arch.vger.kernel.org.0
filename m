Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7C6C5C3C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 02:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCWBmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCWBmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 21:42:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F0D1A679;
        Wed, 22 Mar 2023 18:42:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so80380097edb.12;
        Wed, 22 Mar 2023 18:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679535733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APnkk0vS4YfXoLRqdd/gk0V790AzJyWB3pGNJrKGTFE=;
        b=Apxcp2PUp4GczRR9T+xHNUos9lzvmvvtk9Mu66I6rVmMe95ukA/q4Yr4g39iREOLw+
         hGisw5/dq56ni3djYBzyRupWOFk1akJoLwAsM6pJHgUx1JuaPD0XmLrUkB0nRchP/UOI
         TwFJUtptYA4BgvuOYFNvfjiWchVj1jFWHCX+Zp1VO/unTSVjUR9syk+LsMpesme6gV4x
         kcTnaFS3yPUeerdn0KVSNMge3L7QD69ES7ODpqAR6HBNCPezIN+WqPWrUTmDF3y/v0GB
         l4+3g5IBtKvkb63WlCtWGiNKcZhoABSVj8LR/G2HXH7GaclDpm0E6bS3yQfyzzMuPKQm
         L/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679535733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APnkk0vS4YfXoLRqdd/gk0V790AzJyWB3pGNJrKGTFE=;
        b=YgAxnwweov+NfPfb9niUvGq3EFx/BPXKA1d73akP3fT0KEuRPsGSHcpZgn+slg82Rb
         2kKR7hVACCjpdHBhunnTD/Y2lMZp33umhgw/hEOK37DJeoMUfvx76v2yKFyEkq8LDviq
         9vQ5ISfDciovs/ibbDd1zLDiWB5wfg8YBDVQpmURQTqFLWnStmY3qngVXziyA1m9Sgb3
         BktCIP+ss3ZZvv4TZoIR8U1VMMsGJkSNI33W7V0axDo3y2GOTlRYrrDP6fy03cKFBYh3
         qbn8CNlkULkffnCXF/MG0Jm+RlH2XRBs/TZgSI0TgJ4TKwL6p/FPx+a7htpOvbKK+cBj
         leaQ==
X-Gm-Message-State: AO0yUKVx45/+rPfVaSSo4AYyIk7imcOePJTrmZTnx+SBSHrF86HD8GKf
        9d5QvDH3FbTL22nF9NHl4uE=
X-Google-Smtp-Source: AK7set+V+di6Y6D471B7Dego3A4SUKy4fZrBovS2fMyxyUDnFHLEqRS4iBM+DvVWd/IeSPntcJwUng==
X-Received: by 2002:aa7:c557:0:b0:4fd:29e6:7018 with SMTP id s23-20020aa7c557000000b004fd29e67018mr8577809edr.20.1679535732925;
        Wed, 22 Mar 2023 18:42:12 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id g25-20020a50d0d9000000b00501c2a9e16dsm5555853edf.74.2023.03.22.18.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 18:42:12 -0700 (PDT)
Date:   Thu, 23 Mar 2023 02:42:08 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model scripts 01/31] tools/memory-model:  Document
 locking corner cases
Message-ID: <ZBuucIhuVuoJHljI@andrea>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
 <20230321010549.51296-1-paulmck@kernel.org>
 <ZBrDeoCIs1wmNBeF@andrea>
 <5a32a825-70b3-49d2-9a17-9e5be38e4b72@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a32a825-70b3-49d2-9a17-9e5be38e4b72@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> I was surprised by the need to change the "locations" clauses, but
> applied that change anyway.  Ah, I take it that klitmus prints that,
> but doesn't know how to print out a spinlock_t?

Yep, this aligns with my understanding.

  Andrea
