Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0FB38F8D5
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 05:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEYDcy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 23:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhEYDcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 May 2021 23:32:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBE7C061574;
        Mon, 24 May 2021 20:31:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k19so22242497qta.2;
        Mon, 24 May 2021 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdMV+yTXBLYWIfGHPJPjvdA6uunEq8KJIbegmNZYD/c=;
        b=nZxJS1GyMkdrUlXnZqsln0N1rgFwP5KPv3ofpoHXsLhT6K+NAPkAtSfonFlTC/lig9
         yYlk+stDs8b9P9+j7994vhD8iBvGjCE02+jO5rvHz/LuB8DwyfJXiVXBkM3mu1Jbr7RR
         H//i5ph3s2vAms7s6A/6fuJH8KeD28l7f/hk1yZvYvuyQjvTU9udpg8LAJr3NufvDRGt
         m208NcrW3NqvzZuf+dVZJYj2xoaZjrAGsLCHqhh3Xhtut86df1vE4MFV7GXnuNAat+7e
         mENwoirnXjizdCHjleDMawru2SmmRtUvpZEE0yrtjlar8sVVMWTEkA/CS4O9/HmhRM+S
         KOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pdMV+yTXBLYWIfGHPJPjvdA6uunEq8KJIbegmNZYD/c=;
        b=WzqFyanYzynFx+AjiOO/6wrfG843uDa3bXtWXY0ZkQcu22uIQAwW7zbmNeq9NVmj94
         ViO/ijAZXDnRWQNvOeKD+L/+ZV+YsOZ+kMHhTP25vjq1NFXj+DWUhoyxh8anWBYAXPbK
         aFqLZ2oN8qUf74Gc0TiDItrgkyE8RO5mJyFDeFMqOmMrztDMfyogsAu+CdQP6T5kMdS1
         PO+zgKPPbcoDTZmOkd/IahUaRmbObyIr1IoC2bbv8IKrQ1UBI3tKYQlwZUAL2yHmUZTy
         BYE1qt3jhL4XlA/EzgIFKKYT73wTKLwUFXBIRK+Tgc1+6V9tZheuNeWi3tJpfy4919Kx
         hRgw==
X-Gm-Message-State: AOAM532FME5okLSHp/s4NulLM3dLL/L/N05kGq5ZZRncxEiHpC9JGDAv
        6K3g1VNWyV3ahtTXM5u+7pwrdWeOxkonWGr4
X-Google-Smtp-Source: ABdhPJxctMF5GgRFn0qWe7B8O2au/fPXie++RSCdbuyNRzuiAxsSBTRdamsNVHfPPSqn/jPl8PoZRw==
X-Received: by 2002:a05:622a:392:: with SMTP id j18mr30714495qtx.29.1621913484075;
        Mon, 24 May 2021 20:31:24 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id m15sm11473812qtn.47.2021.05.24.20.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 20:31:23 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
Date:   Mon, 24 May 2021 23:31:22 -0400
Message-ID: <3398848.TK9RqziN78@ubuntu-mate-laptop>
In-Reply-To: <20210524224150.8009-1-rdunlap@infradead.org>
References: <20210524224150.8009-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Randy,

It seems I introduced a new unmet dependency bug
in my attempt to fix one :/

Anyway, I don't see why the dependency on FRAME_POINTER
was necessary in the first place, so LGTM.

- Julian Braha


