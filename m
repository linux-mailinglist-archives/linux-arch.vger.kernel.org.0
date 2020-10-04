Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD0282BFE
	for <lists+linux-arch@lfdr.de>; Sun,  4 Oct 2020 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgJDR1r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Oct 2020 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgJDR1r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Oct 2020 13:27:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8DC0613CE
        for <linux-arch@vger.kernel.org>; Sun,  4 Oct 2020 10:27:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j8so2169890pjy.5
        for <linux-arch@vger.kernel.org>; Sun, 04 Oct 2020 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tj85vc+tFzKQ8Ts1wgqekj2S97wfjTOBg845eefHhNk=;
        b=XzvA1ibYwKJjhuT5kV/gBCfVWaqWGosfZel3llNCYnpQOhIwyifIfQ8jyAzGMCIcmz
         IXTW5yCQRCQ2yNTHAg7p09RQDe/XmI4dzRB2/fGwR1YO26n1KCD+Y278Fm7nYK2uvkYq
         BnVLgkcDRg4Qk73FZ1UcCv1xE8xXDkPncjHn244CzbcWYTd+uPWiIW8uqjWy0tTLLWpP
         mhbXT33DK5yrAgz0kRvpl+10PFWL6PP6DYdEg0LSt9atD8Cn6f0y3vb0HuU6A9naQDHf
         7iM+AA6xDNobK8ePVCyQRSie1VOiOrI55NOMBapYv7yN9quU4/JsEqcKt/WbW81cjsZH
         CO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tj85vc+tFzKQ8Ts1wgqekj2S97wfjTOBg845eefHhNk=;
        b=IvVLumprM1WnyuSkkWNM2ey0Tdm/Vakz0cpfv6W1wxeYX0XPX/ad/hm1cQgcNnDahQ
         3OReT0iyHT2lDwzJvR0Uf6/M8VY7Fw1wbj76gAcWA/UjaNtA3PuwY6dBbMi+oP0NYuzG
         ZcrZ+avPnjmX3RcyHmvWR0grfzsshrcKd4HaMAtxupC/CRATzV7XS10WPpJ9Ki9sowNf
         Qm9ww61Uh0czv00dBKMCjanTvBJSIJimBFs5Xx/Df5wnSn80y7Bk8/XVwefcOtsJlvIL
         DgeXnt0GTq+S6FezVC7Ak3gbdRm4D2ojxVPJbeajThe5ih1FKpBKMGSNbVzRteumU/zR
         Nxuw==
X-Gm-Message-State: AOAM532rvL2RW7EcydvvzBhkAqa5kkSUE+Et75csZIKTU3C4qrzqHTSm
        hlbHJFpkdONffVrDeJ8E6IqKsQ==
X-Google-Smtp-Source: ABdhPJwj4IDhoydeLRkvglo0zKQhrjklU5j3+KfqxjL9fpv2XPSptrijTRwQ5V5iJTKPN9mcSPtL2Q==
X-Received: by 2002:a17:90a:5292:: with SMTP id w18mr13086015pjh.72.1601832466217;
        Sun, 04 Oct 2020 10:27:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 16sm7810102pjl.27.2020.10.04.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 10:27:45 -0700 (PDT)
Date:   Sun, 04 Oct 2020 10:27:45 -0700 (PDT)
X-Google-Original-Date: Sun, 04 Oct 2020 10:27:39 PDT (-0700)
Subject:     Re: remove set_fs for riscv v2
In-Reply-To: <CAK8P3a3ONxXm_MWKn9BSswtLH3etVwOUh52NYoXpj032=WP0gw@mail.gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-de10f104-52e9-4531-8d33-981b0692682a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 26 Sep 2020 12:13:41 PDT (-0700), Arnd Bergmann wrote:
> On Sat, Sep 26, 2020 at 7:50 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> I'm OK taking it, but there's a few things I'd like to sort out.  IIRC I put it
>> on a temporary branch over here
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-remove_set_fs
>>
>> under the assumption it might get lost otherwise, but let me know if that's not
>> what you were looking for.
>>
>> Arnd: Are you OK with the asm-generic stuff?  I couldn't find anything in my
>> mail history, so sorry if I just missed it.
>
> For some reason I had missed that __copy_from_user() change earlier,
> but I had a closer look now and this is all very good, feel free to
> add an
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.  These (along with the rest of Christoph's patch set, and a merge from
base.set_fs) are on my for-next.
