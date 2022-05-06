Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A351E0B9
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 23:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358746AbiEFVKr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444198AbiEFVKp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 17:10:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7886F482
        for <linux-arch@vger.kernel.org>; Fri,  6 May 2022 14:07:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id bo5so7215587pfb.4
        for <linux-arch@vger.kernel.org>; Fri, 06 May 2022 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=iE9UxHskNYHOO3H6FjKnavEf/Vjcp2jY3sbm6CS/ddTi0T1p6m5/UtB6ZYUa6tFOB2
         Ig8MnUmvdShFqU/t2V3sf0VxI8F53A5RIByqyjJykSn8ieXmDiZN6wT5vQH17OT9KbV4
         Wh6XO1gXfmv4kNjTEU5onYMXqtZZ759010DMiwUoke6171scdH4NQYAQ2WJmXpXeG4Hx
         8WzegUtGwAYUuhUrXXfSp/zkWruEJ7Z5A5TDKpIT1zEJL+9Sg719xYm6kAzxSW7LmgU3
         rMPBwREKO585DxQEooB8vVmb1j5yZMIcxbhHz4sA3NqN5AJHa06hHhGOrrSvcrwggGhf
         VOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=o1iYgVgL2yGaod1YP9JDHeCYzmdeSGPcVPgqW5o/CnUAycvrPNlWy2VOet9mO9T+2/
         vun9tWYJFioCIIomLoegHGG0uSLsQyyJFJae5UoAwbxaMbM0IMNQrMUktIojHRPZSBiE
         d+h4l3sdGSNx9Dvde8tCmD3Tz9zTpv4rgg0pbqTjnwkCAY9oRPytOtREoMIBoPwiulS/
         Qkz+YjjLphYWN7e1+OFJ/3aRLqam31Q/mY3zZwP7PLg1HR9DixG8hLHy6xBivE8dlsSy
         Ru8MD8VtWYuonID5mCjI99R1H5hbzQqOBO+SzpYPs5COBru3DtrEYbg/zhoqBhjAbmS9
         zsuA==
X-Gm-Message-State: AOAM531hpWzyjSLoVPtfVYSkvlPPLUkFhr+//Ly0gH3AgoD6bt3iuNJJ
        9GGnjRDjlwcieO2bAAKmsm5jo0F+hO2Qcprrlg==
X-Google-Smtp-Source: ABdhPJxA4tMTEq7P/0jtu2Ff22tn6HCkzNtMoobPUYPQu2Irf9FYCU0bHU5vCBrv2yRsX8AKw6Ct5aygp3lg0aibY4c=
X-Received: by 2002:a63:6984:0:b0:398:8db9:7570 with SMTP id
 e126-20020a636984000000b003988db97570mr4188221pgc.373.1651871221680; Fri, 06
 May 2022 14:07:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:07:00 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:07:00 +0000
Message-ID: <CAD_xG_rvFPU0i04q43u4Eqz-KE8g9V=rM_WOZ+=1a4JauU5OEQ@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4990]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
