Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE66C21B968
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJPZ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgGJPZz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 11:25:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98BC08C5CE
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 08:25:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k15so3419841lfc.4
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XI4AkRHvZrR0Ew7WpXi3OZzQZHVgyOG0so02CQsEE3M=;
        b=Mak2sf3wWVCDN414GX6oHTPld7bJlpmLqrG6bZhvvHH5T1znpXb6u3eHn8BmbMVF+Y
         ds/EyWXY0dD4gBcMZ/gDxgBnK2vyamBCukZjC5DfW83iNLTqsavE5ce6GoriDZi9axdj
         QYdrRPQcQGcNIl30F45Lsgp9hSW8E0/NOQjY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XI4AkRHvZrR0Ew7WpXi3OZzQZHVgyOG0so02CQsEE3M=;
        b=H/ajCgbHfGq/vf1v21hx0gqpBs3ceUqmGz0ZfwoOpCi+1rDFt0NTeomExDHCJdXdow
         FDozN0SjoS6t5SY7R0f1PSJeWwkwYV2v1/IvamtnXbbLGlc4Mtj3B99gAgh4x7ENy0G+
         CTq1nnmMHVlbNLPEJxz3pmw63jzdXlSjo1gyzaS7f3dzVYXcyI+EAe+IEvk6o9tNQ2s4
         HGpGy8TALh0OyUP6PP/sVpld4ncpTeKDRWlLhnBpPkLrjCK67tf+AqQ3EYlu+dOuEJLJ
         fM8IM0j8VoL1BkWX1qcjpJMXFsX9o1H1oDGm3TnfuI2tydoTkmPqP70ZwqqBZP+HZPbP
         Dj+Q==
X-Gm-Message-State: AOAM531l8s68MXAjSPU/OPhrouharD208PckSsKU+XFkmCwoJfQ5nVRx
        TrLFHhYL77aPwxh0fJaJtddNgTEfMh4=
X-Google-Smtp-Source: ABdhPJwldlDkhatDTIdsEF9ZSXelqIzViH6bc5WqfGhTC2kZgV9gtk7QFMUm/kbSazX26MPiBGjmgQ==
X-Received: by 2002:ac2:54b9:: with SMTP id w25mr43724207lfk.127.1594394753713;
        Fri, 10 Jul 2020 08:25:53 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r22sm2280302lfm.30.2020.07.10.08.25.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:25:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id j11so6904814ljo.7
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 08:25:52 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr39413534ljj.102.1594394751710;
 Fri, 10 Jul 2020 08:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de>
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jul 2020 08:25:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
Message-ID: <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
Subject: Re: clean up address limit helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> in preparation for eventually phasing out direct use of set_fs(), this
> series removes the segment_eq() arch helper that is only used to
> implement or duplicate the uaccess_kernel() API, and then adds
> descriptive helpers to force the kernel address limit.

Ack. All the patches looked like no-ops to me, but with better naming
and clarity.

           Linus
