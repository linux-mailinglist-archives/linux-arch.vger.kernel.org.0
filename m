Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306F911CE94
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 14:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfLLNlT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 08:41:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39813 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbfLLNlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 08:41:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so614888plk.6
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 05:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=K1dcdOatOeVeFsIQxT5aEB0ANkvhzz2V9qjht9zfLUs=;
        b=GdElbodEdxjlTrBwa3I6J+sEs4W2s8EoeCX3lxYPy4O5JSwTyZcODXGJSRA1xj4/Th
         5RtnvwUWSB2afNeAL6+3jSXcezJ6aTZ2Ul1yCG9FnmvdgLq0A/BabGqxJQXU4aLQibFm
         sZaLkJC5i3jZy2lEJbSUwiAQSB4z7dLoQktt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=K1dcdOatOeVeFsIQxT5aEB0ANkvhzz2V9qjht9zfLUs=;
        b=nUdHpnYKSqEdDVySTwNNAwWF6vpqx6dhc7ewOU/+TsKpGyGCIPunisF4cwj8/U9M5y
         wkj9ELgIWboMzrTn8FQQ+7of0tFiWosT2wX5qJM02jgQ/UGGOesfwrZCeGGvvzB5vHkp
         HO0pouSxDFln362vPMMtoEQ1dWtfucPkz7DCq36jWt5fRWhzSEQTYrpiA94NVVL+rfN+
         pihEysgIUB2E8v4E6D1mUJvVkdHkJXu6E2CgWHBCxUrBLAexsRWYI8442f6nEljPPufG
         hIrg5QN1LiTHR845ibhAbOauKoMOl/w7+q99+HcjeG8udYuRt788Bt0IPihzKTn6xzvB
         4aLA==
X-Gm-Message-State: APjAAAVbf487Uxr3KbDIHTUYbK7sACkJwdXLN1N+3MleZb+ATNvXdEhZ
        lk1nXlGORzbIrNq0Ck93LNOXrA==
X-Google-Smtp-Source: APXvYqzPs6Cbt1MwcGO7Ifn/65S78x+5CnY2vxScmtjpazHyalO6+YCcj2OzBuBrETruOG5iKaL2pw==
X-Received: by 2002:a17:902:9885:: with SMTP id s5mr9457771plp.217.1576158078207;
        Thu, 12 Dec 2019 05:41:18 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b116-2689-a4a9-76f8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b116:2689:a4a9:76f8])
        by smtp.gmail.com with ESMTPSA id i68sm7464966pfe.173.2019.12.12.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 05:41:17 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <414293e0-3b75-8e78-90d8-2c14182f3739@c-s.fr>
References: <20191210044714.27265-1-dja@axtens.net> <20191210044714.27265-5-dja@axtens.net> <414293e0-3b75-8e78-90d8-2c14182f3739@c-s.fr>
Date:   Fri, 13 Dec 2019 00:41:14 +1100
Message-ID: <87tv65br0l.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

I think I've covered everything you've mentioned in the v3 I'm about to
send, except for:

>> +	/* mark early shadow region as RO and wipe */
>> +	pte = __pte(__pa(kasan_early_shadow_page) |
>> +		    pgprot_val(PAGE_KERNEL_RO) | _PAGE_PTE);
>
> Any reason for _PAGE_PTE being required here and not being included in 
> PAGE_KERNEL_RO ?

I'm not 100% sure quite what you mean here. I think you're asking: why
do we need to supply _PAGE_PTE here, shouldn't PAGE_KERNEL_RO set that
bit or cover that case?

_PAGE_PTE is defined by section 5.7.10.2 of Book III of ISA 3.0: bit 1
(linux bit 62) is 'Leaf (entry is a PTE)' I originally had this because
it was set in Balbir's original implementation, but the bit is also set
by pte_mkpte which is called in set_pte_at, so I also think it's right
to set it.

I don't know why it's not included in the permission classes; I suspect
it's because it's not conceptually a permission, it's set and cleared in
things like swp entry code.

Does that answer your question?

Regards,
Daniel
