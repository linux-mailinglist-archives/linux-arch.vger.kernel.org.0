Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4646E1364
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDMRWR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDMRWQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 13:22:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7C86AA
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 10:22:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y3-20020a17090322c300b001a06f9b5e31so8526545plg.21
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681406534; x=1683998534;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MUWO1kZAYR92KIzOOxoAG6fgcpTDrbsTBnBgIaXB7SI=;
        b=k9K7/cx14r1rZ44+YUmMJA/zyDFSnSwd4M/yoOo6MK1lBZbqEHHMPLqbgmJy4VHzWr
         BHtqD7duSRrul042d0Suw2viax09pK0xMVdFhDXpoxoBfhFfIuBKNDsrnzf3PtlFwTe0
         xZs14NrJu4rjfC+GuieNJRVga4Qv8eQWhGsY7num3+DbmUoQdqIvovvw7B75AYwZTkKG
         iKlZHnMH6l41XSupS5sXqcJVcqX0LpFcpp/+2ct//bBU6UJaLCpcjq4ly/wd092FSy5B
         RAM7fGGTnnv8Bkbvo6qpHrJ0vab0jDHA6Sxzq0hjEQ4MKc/Y3j5NGUn0fKFRnXbWoeyn
         RO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681406534; x=1683998534;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUWO1kZAYR92KIzOOxoAG6fgcpTDrbsTBnBgIaXB7SI=;
        b=j7h6LJHJePXQ2RcG3DS117JQ997rKI6rufrE9U2OZdcDLro8TWIX3TRhNUZSd7V5AO
         ibRYLOxGJCrfClC5j5k+r+V/Ac8711M8L4i/VtFgjJ3sZtoizTIFk7fPGNiqTwKkJXoI
         mXpjb2Apg3E+FIoBYTSH7C0u6TC4oHy8VNGR8idmJItocZQp9sUnLBHY5dx9ZBD0E2x1
         MBHk4SKMo+2aVYaLhg9ejVVo5iDeYwVyZ5D+lLTfd+kLZA0A037a+4uCx7dPS4ddq+eF
         fWb2JsPziwi6G9QA646OAegl5AwAUXVKRf4nXPc0kVX+nywbhSe0wYTE80mhJKfpNyuK
         yjcg==
X-Gm-Message-State: AAQBX9ee8UyfEpEiH6Pm2wOKEwxhMnmtI/0d66ZS0yVl/bF1QvOkVW+T
        pT5dB2CjHTDYDEvIHkY7sg/yeHAQtYVMAxSCrQ==
X-Google-Smtp-Source: AKy350buit0TKoFObhZndLsv+Oe7SecvOYrJwebJQwpxXJ4Pb+22Ci4SNV5J0w0/4fgc4zy9sZpOZtI2T9SDAix8Kg==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90b:815:b0:246:a1b2:77fe with SMTP
 id bk21-20020a17090b081500b00246a1b277femr2564960pjb.3.1681406533842; Thu, 13
 Apr 2023 10:22:13 -0700 (PDT)
Date:   Thu, 13 Apr 2023 17:22:12 +0000
In-Reply-To: <20221202061347.1070246-2-chao.p.peng@linux.intel.com> (message
 from Chao Peng on Fri,  2 Dec 2022 14:13:39 +0800)
Mime-Version: 1.0
Message-ID: <diqzh6tjofy3.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        pbonzini@redhat.com, corbet@lwn.net, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arnd@arndb.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, x86@kernel.org, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com,
        chao.p.peng@linux.intel.com, kirill.shutemov@linux.intel.com,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, qperret@google.com,
        tabba@google.com, michael.roth@amd.com, mhocko@suse.com,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Chao Peng <chao.p.peng@linux.intel.com> writes:

> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

> Introduce 'memfd_restricted' system call with the ability to create
> memory areas that are restricted from userspace access through ordinary
> MMU operations (e.g. read/write/mmap). The memory content is expected to
> be used through the new in-kernel interface by a third kernel module.

> ...

> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> new file mode 100644
> index 000000000000..56953c204e5c
> --- /dev/null
> +++ b/mm/restrictedmem.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/sbitmap.h"
> +#include <linux/pagemap.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/syscalls.h>
> +#include <uapi/linux/falloc.h>
> +#include <uapi/linux/magic.h>
> +#include <linux/restrictedmem.h>
> +
> +struct restrictedmem_data {
> +	struct mutex lock;
> +	struct file *memfd;

Can this be renamed to file, or lower_file (as in stacking filesystems)?

It's a little confusing because this pointer doesn't actually refer to
an fd.

'memfd' is already used by udmabuf to refer to an actual fd [1], which
makes this a little misleading.

[1]  
https://elixir.bootlin.com/linux/v6.2.10/source/tools/testing/selftests/drivers/dma-buf/udmabuf.c#L63

> +	struct list_head notifiers;
> +};
> +
> ...

