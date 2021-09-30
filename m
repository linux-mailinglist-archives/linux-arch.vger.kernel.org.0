Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE241D72C
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349754AbhI3KHS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349744AbhI3KHQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 06:07:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BBAC06176C;
        Thu, 30 Sep 2021 03:05:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 75so5693051pga.3;
        Thu, 30 Sep 2021 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUCu93B1vpXOt7rVT/VHSEoF5/1bf9+fBEaKI0gkxts=;
        b=frK6mzU85ZlJgrbQyDP5MR6HkaDdlSc5oWEvc1hMs4/CwyQEqeJoalPGX+A6+szh3I
         eL5LwgF0yD4HTYn32Zzh9cb64UOH1QwYoPshrX7CRRiAxeSZ6ItMAEIj5DHUEfNfY2Sq
         IgWrBo0vtDPK2TorEPYquYMigT+ujOgNjtciA+Pzut1J2qWdPmMBvfVOvwOPBtQ9BQ72
         dmTe7B97D5nNx0rhPVL98ojMyUuDifYRXuU/RmQoT9+wanpvZRX8ElWvD/Mc9rsABjCs
         gJQJPOqleg8+/pi/Trh31rQUg4KjOHTenOTIgooDowza8Kxds2Yj2dxMMnuuvxp/ZxyX
         EwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUCu93B1vpXOt7rVT/VHSEoF5/1bf9+fBEaKI0gkxts=;
        b=oa/plI1RUWXOJ8Vzd5v1WS+PzMJz3ssl1GoEzV3Efdd/ChvE+7Vk6h34Qm6J/BO6C1
         txaR+QWW4f7RR2Zg6qJwx8KETCGkGNldsnoW6HOT4lbgsTit+co15NJ6DHIycP+72DOL
         f6RluFLeTzztVqZaqgSyf5zJ808Ba6qOTLB1mCAMqU4mT0vrzG7SQPiDBFwPrW7x+vTb
         A3G8mtforzzEBZTFejQXVeaMe6EyWsHXGp/H8IzcX/fLAexZojtO3okNbW2niEl2ddIa
         RSo22oFoYWxTfFR5PpeGha084uXeGAUhlpdeV2kgBI7nSk3lRFtnUOSCykHtkewRgSs0
         Ah2Q==
X-Gm-Message-State: AOAM531eAQnxUTMXTshlaETv+i59ptg1pGkYTyLhN7zQHcK2IH/u9yP3
        r8iiF2UFX6V2gBWP7AIDPoQ=
X-Google-Smtp-Source: ABdhPJxLpBoDLentgowSq7BYVkZbWr8XcA59pOS1I/wl7T+PKz6q2YUwlz95jj+3g9bSzgrzAod7ww==
X-Received: by 2002:a63:131f:: with SMTP id i31mr4178307pgl.207.1632996333691;
        Thu, 30 Sep 2021 03:05:33 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id 130sm2568262pfz.77.2021.09.30.03.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 03:05:32 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     alex.kogan@oracle.com
Cc:     arnd@arndb.de, bp@alien8.de, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, guohanjun@huawei.com, hpa@zytor.com,
        jglauber@marvell.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, longman@redhat.com, mingo@redhat.com,
        peterz@infradead.org, steven.sistare@oracle.com,
        tglx@linutronix.de, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH v15 3/6] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date:   Thu, 30 Sep 2021 18:05:14 +0800
Message-Id: <20210930100514.10121-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514200743.3026725-4-alex.kogan@oracle.com>
References: <20210514200743.3026725-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +/*
> + * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
> + *
> + * In CNA, spinning threads are organized in two queues, a primary queue for
> + * threads running on the same NUMA node as the current lock holder, and a
> + * secondary queue for threads running on other nodes. Schematically, it
> + * looks like this:
> + *
> + *    cna_node
> + *   +----------+     +--------+         +--------+
> + *   |mcs:next  | --> |mcs:next| --> ... |mcs:next| --> NULL  [Primary queue]
> + *   |mcs:locked| -.  +--------+         +--------+
> + *   +----------+  |
> + *                 `----------------------.
> + *                                        v
> + *                 +--------+         +--------+
> + *                 |mcs:next| --> ... |mcs:next|            [Secondary queue]
> + *                 +--------+         +--------+
> + *                     ^                    |
> + *                     `--------------------'
> + *

probably not only related with NUMA, it might be also related with cache topology.
For example, one NUMA might has a couple of sub domains, each domain shares some
last level cache. ZEN, Power and some ARM servers all have this kind of topology.

lock synchronization within this smaller range should be much faster. anyway, it
looks like a good start to be aware of numa only for this moment.

Thanks
barry
