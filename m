Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418B7287B5E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgJHSLJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbgJHSLJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 14:11:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CC8C061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 11:11:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so6738119ljn.13
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjD1KSncOo5Ri0vBNockhBjSkP42whD/zdmrAhwOhk8=;
        b=uoJfnZrSZJcQ8iw2fadisI6MQAcc2NzqWTgGTXoayQScwTTp/YIATi4QApVhYnjNaZ
         ToJJVqYETbCS75r6Tw5GhXfGbtOJxefSB05hxbxdB3ONQQkL8WSHJS+D4YCvPt9lbKRY
         PbsKUS4xOU6vCW7ztNMXLvEVDkcWd3GqtuOseMAP0NCgckKzJHTacu4xSrkcZj2j+nHH
         Cf7TmXyhco7dp37xP30Ucm3zYZldE2iiaZKCpQgPT13kiVEA723qlH9sLJyVVn1Q73Yi
         06Q3XGE8ZA0ltVdi5YZOx7O/wbpYFKLmm1U4qq81BS+Unv3zhZmQvxAA30nx6wcliSR6
         7m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjD1KSncOo5Ri0vBNockhBjSkP42whD/zdmrAhwOhk8=;
        b=B7x5Uh1PxW1buif/dCva3FEz3xdkaNB/NvyD+j+sxHp8IYrtOhQnX/ImAQrCTycxSN
         uIdSpPVjSdwi1PKKxsl942DPodlH9P9XwrGu4I6xn5fdjogmuVht1DfPVV+jCKW5YGoq
         2vIV5ZcHCPpKEEL8JKCAIbzslkkBQG1iYlHsJOizxh9VZI05vbXIDVeprYAQMDVPUlNs
         nMg6A/CVx15eSTh/ICSEJ5jE6ZxZVk/Ozy6SlbQPU7etGI6hiIb6OYYWYEShC9kh5w5Q
         9hS/5DTO1n1c/hV31xgjj07ceXWzN6fCboezh6KMnMyxwVWGOfdB5TmWTQ+V501pQCHZ
         zw7A==
X-Gm-Message-State: AOAM533/INDvjn/WEYJLi+jiq2QEswLJZRmF/ZJ5HN+3aunLaNlm0509
        X26jDCDumJwgqrzf7xhn+r/gcZdrt+9jB95Chek=
X-Google-Smtp-Source: ABdhPJwzOl6v1x3ZIcO8BtdUVBgGbMHYbtp6mIMDyCiwl5xecBdQq1eIiT/ksaWtiRKHQtn/jVhDgA5SmRW8+q1bHaA=
X-Received: by 2002:a2e:2e19:: with SMTP id u25mr3495193lju.349.1602180665852;
 Thu, 08 Oct 2020 11:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <9494c2558406a8fd2938fef0c470dd640b7835ed.1601960644.git.thehajime@gmail.com>
 <0563db2b81f44028515e19b8edeb50e1cf29d922.camel@sipsolutions.net>
In-Reply-To: <0563db2b81f44028515e19b8edeb50e1cf29d922.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 21:10:55 +0300
Message-ID: <CAMoF9u2zohNEtqYxEPNZBkW_XJvnAWo3OHtVo3jva8+c94Lksg@mail.gmail.com>
Subject: Re: [RFC v7 09/21] um: nommu: host interface
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 7, 2020 at 6:45 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > This patch introduces the host operations that define the interface
> > between the LKL and the host. These operations must be provided either
> > by a host library or by the application itself.
> >
>
> I kinda find patches like this very pointless ... you see nothing, and
> can't really say anything. Maybe add the infra with the first user?
>
> > +/* Defined in {posix,nt}-host.c */
>
> That doesn't exist either yet ...
>

Noted, we will fix it in the next patch series.
