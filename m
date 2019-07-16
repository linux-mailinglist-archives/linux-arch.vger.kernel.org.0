Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3886E6A8E3
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfGPMqn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 08:46:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43937 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 08:46:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so19344549qto.10;
        Tue, 16 Jul 2019 05:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qkt/rcNAyGB5yeoQzmqBk/ZrkdptMq68hzIGgc4mhYc=;
        b=AHOlCUlZP/8v5hbtsZPvRw3zr9xgd0EgnISXAZHDZB3t8wcCnWaQrnrxi05lpFaHBz
         0efhW9/kSMyU5zYuaREKI/RtJ7RCVZ/cJXYFc2vmgQ7QVAn0jXzFACVHhqBdt14wKJ5p
         m4gf9CQap7oq0qwABY15sInGsMrXi4ihhTSt9iwIhUNRmzYw92Y2fibuw2r0ModdCAPB
         6LskclK/3yp1+mutmfBsPbht2G0kMydYtnDLfeU2ATlkruLlA/OkCntJKp2jb4o39tKv
         x/4lDpyh1oNUWfOGX4Uv0kqPkA3o7PYuW45H35KSoT699LI5tKFbeqX4TSmqJrhPdpkF
         gUsA==
X-Gm-Message-State: APjAAAUxEDAAyLgJvLP5q5ZUNCWLcHtHedsj5E3ylMBu8nza1hyDnTSD
        Wtb+tJxK4sMPHH9sm22uka7cEkQ42OxpiUl0exE=
X-Google-Smtp-Source: APXvYqzQFA6+gMcUc2FK4KYgzt1PHuepID8c4iz/5AaJBvfTSVfBFY3ljJdtgzI9JsKM4gnSPxHGS3O09A+A8FOTmqU=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr22767682qtf.204.1563281202046;
 Tue, 16 Jul 2019 05:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907151513450.1722@nanos.tec.linutronix.de> <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
In-Reply-To: <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Jul 2019 14:46:25 +0200
Message-ID: <CAK8P3a208iz_Ra2CwsRvCmcDiQcUFyAO54SNrH3B+dRqpw9ykg@mail.gmail.com>
Subject: Re: [PATCH v2] futex: generic arch_futex_atomic_op_inuser() cleanup
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 8:22 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> generic smp version of arch_futex_atomic_op_inuser() always returns -ENOSYS
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I see what you mean now, I got confused earlier when I looked at the
non-SMP version of the same function.
