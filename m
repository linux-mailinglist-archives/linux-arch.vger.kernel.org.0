Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55BC2920CD
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 03:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgJSBAZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Oct 2020 21:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgJSBAZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Oct 2020 21:00:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1363C061755;
        Sun, 18 Oct 2020 18:00:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w11so4137290pll.8;
        Sun, 18 Oct 2020 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=bWoMKVJ1YgSUTf5JVsRMziiYu6V0bjJDwj61vEVEUCw=;
        b=iVM5ap/CPWatRDHPNbFcrK0+YSeezZ1602xdP5jpd7nWENNgo83a+281NE3RosvsA9
         3Zu/LQXeo9pbrfow3mRVJjTl6EGXHdirFAK0MgxzjSC8toWGe6k2rT1KctZt9a+Y2WWE
         NbDk8gN0/qW2nZNTtqck+rN4GotvjwiLRBNI6HVP786PqKtZ0ovd3e2daTZYwpWNEpE/
         q9lR8kux/1dtToL8tvls9/KjLHN8LxwgLBgXzqckL7bDb3HZqz/hEBSIjjcwKx0UlzX4
         GK+ov5bYVU2m9vt57KLT4IvGzxV4DOzEetpvd3NQ8d/4WdphoeYBcfM0CMhDySWav5JI
         ELrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=bWoMKVJ1YgSUTf5JVsRMziiYu6V0bjJDwj61vEVEUCw=;
        b=UtYRSto8QSByLDeGSO/dWWvcpXWMWEwJniINH1G3G9XTdU51VmbZiE1fGRF6QPqXtV
         5034Y9xyYk9UnfzgEUD/4JE4YGGElcpMY4gy0k4UVmpaljkrsX39yT+n2GJe5M/Ie1zx
         12cTQWEZ+7YwTluXCwkoaRQWJZ6TqZU8putqo4SNFGhynMLeZt0jdOp3mYXI+XqEuEId
         +LUudBRH215hT0Bdio/ibN9co3YwjdfdIfF1cQTg20H7c1/U28h3njRUugtixxAOHB4N
         c1NwnxtfR8DQm72cPzgQn542Q4+4gPwSYtM1BtnOI0U6xlp4xjdmkGesjL69bujZHuya
         rwqA==
X-Gm-Message-State: AOAM530xlAD2Pnbc3kpMaF5F84Mn962FAgWuU1AjPYgf+bm/IHvoQtT5
        I6k8IH11ZyaVY5Mrq2OWtmR8zptsa0I=
X-Google-Smtp-Source: ABdhPJzuM+UFzcdRFrfkF3QURYjFN1fpv1YaOqefDXLCBEPOxpVvUrn558Hj70wcIb9w4WZXOC596A==
X-Received: by 2002:a17:902:8693:b029:d5:d861:6f03 with SMTP id g19-20020a1709028693b02900d5d8616f03mr6947093plo.19.1603069222495;
        Sun, 18 Oct 2020 18:00:22 -0700 (PDT)
Received: from localhost ([1.129.225.76])
        by smtp.gmail.com with ESMTPSA id f8sm9521648pga.78.2020.10.18.18.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 18:00:21 -0700 (PDT)
Date:   Mon, 19 Oct 2020 11:00:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 00/23] Use asm-generic for mmu_context no-op functions
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20200901141539.1757549-1-npiggin@gmail.com>
        <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
        <CAK8P3a1XqhV+7OVgWhGg3az4Y+_6V-mCjcJ1dBenwD+ZUaaT9g@mail.gmail.com>
        <20201010130230.69e5c1a5@canb.auug.org.au>
        <CAK8P3a0EgaGEtOQzsjR8YhALAaSxScsAhaQLMqU9UmEdhKQ+-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0EgaGEtOQzsjR8YhALAaSxScsAhaQLMqU9UmEdhKQ+-Q@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1603065477.1e6v5lt5b2.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Arnd Bergmann's message of October 10, 2020 6:25 pm:
> On Sat, Oct 10, 2020 at 4:02 AM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>> On Fri, 9 Oct 2020 16:01:22 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> > Are there other changes that depend on this? If not, I would
>> > just wait until -rc1 and then either push the branch correctly or
>> > rebase the patches on that first, to avoid pushing something that
>> > did not see the necessary testing.
>>
>> If it is useful enough (or important enough), then put in in your
>> linux-next included branch, but don't ask Linus to merge it until the
>> second week of the merge window ... no worse than some other stuff I
>> see :-(
>=20
> By itself, it's a nice cleanup, but it doesn't provide any immediate
> benefit over the previous state, while potentially introducing a
> regression in one of the less tested architectures.
>=20
> The question to me is really whether Nick has any pending work
> that he would like to submit after this branch is merged into
> mainline.

Not for this merge window but I was hoping to submit something for
improving lazy tlb handling in the next one.

Thanks,
Nick
