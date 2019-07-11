Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E551165488
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 12:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfGKKdD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 06:33:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38504 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfGKKdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 06:33:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so2560023pfn.5;
        Thu, 11 Jul 2019 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=QgO0JaQSHY4vnem11Q6Fyo0jOFA4EUMpQN6nqlQarLg=;
        b=DQ3GDRDo6ZuNjOSR3UHG+s0d1LxNGZvPzSaJsIYp8+OlmUuBgFj2VuEbOTBNaoZ0eh
         KYzMXtEBMS67xXmsEThDtXCMiOFl/wHg/CXkj5erKCm9McDmtXT47vJYVN5WS/CjEd23
         QHdQpKkAnHuI4SKeKAKPjdekPIyChEv/k676up6oVrY9q1wQLkDsteR1EDalAYrX5eY2
         ibHvDy4SxcNPGMBafYmo8C9MtWx6buDs95iahvNPf7v8Ha2+luXs2UVS3kE72gFoto8b
         bVeGwP2O5573U5C3Ylu/Iu4mXvP3yLfZH5jsWU+YUZAPiTTiAN8NlvfcQTm82GR/APzM
         ld0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=QgO0JaQSHY4vnem11Q6Fyo0jOFA4EUMpQN6nqlQarLg=;
        b=BLREN/zLVEN8Z+rsz55Bn+Hoe3gQm/XZL3YSj6M04mVzjIPNKlhyGq6L4DGkTzUh15
         ED8ck54hnbuijTASl1e6tgRys+e6TVmf7GuBkGEkALutZimiM6elNwIG7KglXXe36Qs4
         iAy+M9Vxknyq+8eIStC+LlbiWkJbvwScrfso+hprdaQj9Eek5hbf/IPDe3lVZ7+FNebH
         3pv3hpCb9p7vMs+Zd2AbM6Gl+YezWu9YE+PdQeTRwuLjo8k8N5bjZGlek5u8bAT1NChP
         04z2JBBb7Gx3KL8EorF1S2kSWs3FLvxP3rZ3o7HdTymgbG9kEcde2L7JXoLqRD9iwb2x
         XUNg==
X-Gm-Message-State: APjAAAXEL47Fg1FOCcNyIIB+UibKRa4mBgiT5PnOD+nEP/I0EuJ0U64K
        HBOOv8MPuC+mxFNOimfEkQYkaDPOJyE=
X-Google-Smtp-Source: APXvYqzK0dRwEomozlBD3wvw4N40TKmDcZvFjPBT8AONodHNnHkIbT1P1WOUA7C7HYFWruPQhFDFWg==
X-Received: by 2002:a17:90a:26e4:: with SMTP id m91mr4017907pje.93.1562841182209;
        Thu, 11 Jul 2019 03:33:02 -0700 (PDT)
Received: from localhost ([220.240.228.224])
        by smtp.gmail.com with ESMTPSA id m10sm4677307pgq.67.2019.07.11.03.32.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 03:33:01 -0700 (PDT)
Date:   Thu, 11 Jul 2019 20:30:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mm@kvack.org,
        linux-sh@vger.kernel.org
References: <20190711030339.20892-1-npiggin@gmail.com>
        <20190711082539.GC29483@dhcp22.suse.cz>
In-Reply-To: <20190711082539.GC29483@dhcp22.suse.cz>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1562840680.snxfuzmtxv.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michal Hocko's on July 11, 2019 6:25 pm:
> On Thu 11-07-19 13:03:39, Nicholas Piggin wrote:
>> Remove page table allocator "quicklists". These have been around for a
>> long time, but have not got much traction in the last decade and are
>> only used on ia64 and sh architectures.
>>=20
>> The numbers in the initial commit look interesting but probably don't
>> apply anymore. If anybody wants to resurrect this it's in the git
>> history, but it's unhelpful to have this code and divergent allocator
>> behaviour for minor archs.
>>=20
>> Also it might be better to instead make more general improvements to
>> page allocator if this is still so slow.
>=20
> Agreed. And if that is not possible for whatever reason then we have a
> proper justification for the revert at least.
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks. If it's agreed with ia64 and sh maintainers, I can send
individual patches through their trees, then the removal patch
will be functionally a nop that can be easily pushed through.

Thanks,
Nick
=
