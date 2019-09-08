Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC4ACB93
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2019 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfIHIdD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Sep 2019 04:33:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42260 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfIHIdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Sep 2019 04:33:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id q14so10561834wrm.9;
        Sun, 08 Sep 2019 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Dvenms9Y7ILBHUAT3jSNMNmZR/R8ixW/QNiX0T3fndY=;
        b=Xy0s84Epf/0r5ThM7KFlOlfZVD9d9Ci5oqr03zZd2VEm3Wi/ir6LN98a2DQWDX1j8/
         TLY4i4EW/VS7X/9Qk5MR6xTXW5Xwp/Yk42/OKbtWmzAEnbbMOHgwhnEIGXoRWJiJPvaW
         keLOxQ3LcKHLh8Sjw+k/LOLV7qVHUjsciT7T5sqN5+1E9yLr7Xp1Ls3SUahRLTXCGKuZ
         TN8O6j+iE5YBIikJvz8S5jBB8UsSE/lzygxaC5IiN6jne2TV4m+DkcsFdCYtcdGfD7RL
         Z+RWoW0KaAYISaO9iSHM71cX9bH2mGEa/l9VSmK19bTHtSWd9XX/VSVDjo+1zerG/v50
         cMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Dvenms9Y7ILBHUAT3jSNMNmZR/R8ixW/QNiX0T3fndY=;
        b=Q5RdJoBh1GVY3SL4JTs8NjnkJrjGq4qC7CFIQMfMHz0C4bthroWtYlWtMohiL4iN/B
         M5GfO/LW2S0axAWFPtEA9JUDIFB9MVzgcGva8NYokXHhpUlHdQNlFUMt+DAG3rW5nn89
         SfTSBcsCq9pQgnqGhXxudaxo4kxTAvY3v5IvyyItL/PHexwGAKPvCu4RBdDVmMVqJ27b
         V0UATyvFmMOEXUdm9ae6V/2XpKppJR7lvqfFN5EXnq7skomiuFT/8pVfBnt8CS8mI3rW
         gXrhgAfQabM/91MXrKFUY6+YOprWHTY5Q6Ts9PtSBNPCMBJMSk6FjAq5eMvSuZndprF8
         SeEQ==
X-Gm-Message-State: APjAAAUcWRx3QK3d+ZKDcZKrug8BnPV82HybtdJmvqQhFfcppjUMh/kr
        Vx7X5qrO7+y7wf6J7vGJObI=
X-Google-Smtp-Source: APXvYqxmEXYD4KfHG33ISQrdtsla0hWkLH3IEJfmTrLErV0Ihc/bV5nsvOMFY9z0b/uum8iYI9GRGw==
X-Received: by 2002:a5d:49c2:: with SMTP id t2mr13914364wrs.351.1567931581038;
        Sun, 08 Sep 2019 01:33:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u68sm17085458wmu.12.2019.09.08.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 01:33:00 -0700 (PDT)
Date:   Sun, 8 Sep 2019 10:32:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, bvanassche@acm.org,
        arnd@arndb.de, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc/lockdep: fix a false positive warning
Message-ID: <20190908083257.GA126088@gmail.com>
References: <20190906231754.830-1-cai@lca.pw>
 <20190907070505.GA88784@gmail.com>
 <420D09F4-FC19-421C-AE46-4B2A9157FAE3@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <420D09F4-FC19-421C-AE46-4B2A9157FAE3@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Qian Cai <cai@lca.pw> wrote:

> I thought about making it a bool in the first place, but since all 
> other similar helpers (arch_is_kernel_initmem_freed(), 
> arch_is_kernel_text(), arch_is_kernel_data() etc) could be bool too but 
> are not, I kept arch_is_bss_hole() just to be “int” for consistent.
> 
> Although then there is is_kernel_rodata() which is bool. I suppose I’ll 
> change arch_is_bss_hole() to bool, and then could have a follow-up 
> patch to covert all similar helpers to return boo instead.

Sounds good to me.

Thanks,

	Ingo
