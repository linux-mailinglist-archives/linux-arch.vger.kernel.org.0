Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8811A41D6A4
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349547AbhI3Jqr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349538AbhI3Jqq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 05:46:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59AC06176A;
        Thu, 30 Sep 2021 02:45:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23so3816077pji.0;
        Thu, 30 Sep 2021 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1OzCcqk/8oU1iiQtZiff+c0LD7WXN2Dr+N/5kW8Y/w=;
        b=leZsCulADGgfpy7H8GtxuB/53eNKGUUzTPwgdmZxb86Er0xlqHcy7OJFiceyTKou8V
         w07WBDlvvLAhgFGowk7Ijpkwc2cdMBsJaCcAHCTMVQ8IYG1Y2FpcKysorjkVUVgIJHHG
         evDL8I4XLwNq4UgDwQGVihqoZEwgoJiUzl/7xbq8A70/bngMOMbGAyh95Wt6L/qdW6zD
         GYeMQebRiiQ2rcdQGO1QcVcsNul5j7617OllI48+0MSZEscHfjBKVSqPNMFULLHWahz5
         OAAUk9P+eq633U7YoB/8skhznT7QvrGlQ1WeSi8DK2zdFeV9Wv4WXXvIpKGqMT2MLwW8
         YV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1OzCcqk/8oU1iiQtZiff+c0LD7WXN2Dr+N/5kW8Y/w=;
        b=ipqvvj745tAeNNUtdZsuJUYMDZDEqdPK8V4CXMyBfkG2bTUBH79iY/F2l2RUV0n3wP
         adx1UZ1wkd5+BQ8sqiYTERtIdtt30M6+M5s4ylX3ZHI8Jy7qK6k9LoOwv2oL4xv43i2D
         rTpUJbUgI1k/uKtkxehM1YLlsPgTSLvR5lhxQDrbHWWVip6kA6qeKdfehoYxF0z5n0Px
         Ue6QvA4q8skjW+/xz9Jizdxhd7AieVA6qtEb0Uso5Ollv2lhr6Dm6DkaDxk+BE4x7+CH
         wnUSmFBCZv9tDVbK1LzYpQL+1RukEDbrlS6FGXmLfpF6Kv53MhhntKbaLEJgidMEQBgK
         yB2A==
X-Gm-Message-State: AOAM532EiMMxoUA2mQRTmJGOivMhi1H26EpTcBTihwNWBB5tPBa0EAbP
        z5Gy83jaq1CMYZslpZuZVUk=
X-Google-Smtp-Source: ABdhPJyQOefdPYXaTArfv5rEHWjm93zwDc0WGVgjU8eSeG6uBKdLDvsCELVteGXLTRNqx4Tmue6LgQ==
X-Received: by 2002:a17:90a:6286:: with SMTP id d6mr5407637pjj.199.1632995103404;
        Thu, 30 Sep 2021 02:45:03 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id ha24sm4460430pjb.32.2021.09.30.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 02:45:02 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     alex.kogan@oracle.com
Cc:     arnd@arndb.de, bp@alien8.de, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, guohanjun@huawei.com, hpa@zytor.com,
        jglauber@marvell.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, longman@redhat.com, mingo@redhat.com,
        peterz@infradead.org, steven.sistare@oracle.com,
        tglx@linutronix.de, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
Date:   Thu, 30 Sep 2021 17:44:47 +0800
Message-Id: <20210930094447.9719-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514200743.3026725-1-alex.kogan@oracle.com>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> We have done some performance evaluation with the locktorture module
> as well as with several benchmarks from the will-it-scale repo.
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). Each number represents an average (over 25 runs) of the
> total number of ops (x10^7) reported at the end of each run. The 
> standard deviation is also reported in (), and in general is about 3%
> from the average. The 'stock' kernel is v5.12.0,

I assume x5-4 server has the crossbar topology and its numa diameter is
1hop, and all tests were done on this kind of symmetrical topology. Am
I right? 

    ┌─┐                 ┌─┐
    │ ├─────────────────┤ │
    └─┤1               1└┬┘
      │  1           1   │
      │    1       1     │
      │      1   1       │
      │        1         │
      │      1   1       │
      │     1      1     │
      │   1         1    │
     ┌┼┐1             1  ├─┐
     │┼┼─────────────────┤ │
     └─┘                 └─┘


what if the hardware is using the ring topology and other topologies with
2-hops or even 3-hops such as:

     ┌─┐                 ┌─┐
     │ ├─────────────────┤ │
     └─┤                 └┬┘
       │                  │
       │                  │
       │                  │
       │                  │
       │                  │
       │                  │
       │                  │
      ┌┤                  ├─┐
      │┼┬─────────────────┤ │
      └─┘                 └─┘


or:


    ┌───┐       ┌───┐      ┌────┐      ┌─────┐
    │   │       │   │      │    │      │     │
    │   │       │   │      │    │      │     │
    ├───┼───────┼───┼──────┼────┼──────┼─────┤
    │   │       │   │      │    │      │     │
    └───┘       └───┘      └────┘      └─────┘

do we need to consider the distances of numa nodes in the secondary
queue? does it still make sense to treat everyone else equal in
secondary queue?

Thanks
barry
