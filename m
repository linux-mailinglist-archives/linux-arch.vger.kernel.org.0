Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA78220C450
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 23:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgF0VXj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgF0VXj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jun 2020 17:23:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54DC061794;
        Sat, 27 Jun 2020 14:23:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f9so6214936pfn.0;
        Sat, 27 Jun 2020 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mizxgkzS/h5RAiTRnXHHAMYgNZSKy87tz0psMUuXu0c=;
        b=KrOHe2AlaGQ7tV28Vl9qyOQ0elfd8r//wq4xzvB5xDb5jWlg6mXfsKxabi0zi9yPbE
         a3CGp38U8cqw2mebqkt6TnvwzPA6E6KEcgpIj8HCQ1rHyHT3QVxyrownujSHvkYTCVSa
         Gy95rzA2weVyQoDCaBGwSARvG5wXI2h42LYwK1iUZUWKUYeZG14+sFo/aPCYLw2NwZJj
         nBqydL7WFvWCAVkBuzJ2gva+wATslrp9imqMIKL3E0H/YMoAyiaNhBbjIsjfeCv51DOd
         WRdGRRQ8YZYlJSkPBIPY8Mf5k8q0bkdsr138mWgQL9YfzyKrJwEngJSJT/C0ZJyP38ue
         p6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mizxgkzS/h5RAiTRnXHHAMYgNZSKy87tz0psMUuXu0c=;
        b=WL5XpW+ecyqMidd+epiIEdTGXOpDdY1OzGTc9e11WJZQAeE+PCot1Rl7hKWyW2Pw+i
         BCgxyGZLfayOq7kE63ciWQGohAhNuK9+gYynA5kEXes899u+p15Br/kwQxajkRyPI9Bo
         POv7KSQP126MCTmALZJOhGoyDlOgZt6scb7yaSz+NLQTJ61zi+RFY83dT1dStDjhjS85
         3Cj5At/iHhpGdmigOIB5jXLYrvJeYa/LHz3aLJtpXIP7D/6MORQ7lcl6g+ddbh6Hc7/2
         DxyBeXu3zBOvxLun3YZr1XxhYdIrhgT2pjZli1+d3HjRQD8Oi1bUbijlqFRWWdcIWwMc
         YoNA==
X-Gm-Message-State: AOAM531mPBFfXHW2bJOYyAWxjVmDg9Lw4YVbSUmJVkUnYWpcF/6HQ7d+
        JYL/XN5aeYDQLnAXt6CpebwweO2oE20=
X-Google-Smtp-Source: ABdhPJyLzAtm2TextcgHnw6pDE2t7RidtLOm1t9FNzgTafND17DEExqOaKhxKo2F07v49LSV9JtDbQ==
X-Received: by 2002:a62:e305:: with SMTP id g5mr8523544pfh.115.1593293018476;
        Sat, 27 Jun 2020 14:23:38 -0700 (PDT)
Received: from localhost (g2.222-224-226.ppp.wakwak.ne.jp. [222.224.226.2])
        by smtp.gmail.com with ESMTPSA id mw5sm15217406pjb.27.2020.06.27.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 14:23:37 -0700 (PDT)
Date:   Sun, 28 Jun 2020 06:23:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/8] opeinrisc: switch to generic version of pte
 allocation
Message-ID: <20200627212335.GJ1401039@lianli.shorne-pla.net>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627143453.31835-3-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 27, 2020 at 05:34:47PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Replace pte_alloc_one(), pte_free() and pte_free_kernel() with the generic
> implementation. The only actual functional change is the addition of
> __GFP_ACCOUT for the allocation of the user page tables.
> 
> The pte_alloc_one_kernel() is kept back because its implementation on
> openrisc is different than the generic one.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thank's for this.

Acked-by: Stafford Horne <shorne@gmail.com>
