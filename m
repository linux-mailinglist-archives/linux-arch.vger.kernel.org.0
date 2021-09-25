Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C5A4181CA
	for <lists+linux-arch@lfdr.de>; Sat, 25 Sep 2021 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbhIYMKT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Sep 2021 08:10:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbhIYMKT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Sep 2021 08:10:19 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632571723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2B/DnmBtUTdcjfM1I8ybzwGAyOjG6d7ZfGM/cv0fB8=;
        b=3xSA4uJrcj05si1FtYNZ2gjHPgD+iZ3ZzFnVsR+SgUx5njX7sbDGiyw+ocIZ4L4EsWmfjU
        GeoM4tBxBbSdGX6VPKH1EsY7i3KapzZsFJD/izk92L1dba9MaRgYGfSnxuSN3Oi5Ie3NSL
        vBk0DyeW9hsAY1KhfdnwqE7TXATl3UPBUg69UFlCAcWphH3z1hqrefcDATSz8mxK25BqcG
        UNod0jc26wnkW0zfKnAhdtpw6RMG6XE2KVyVOHVD+W75zSnB37J1LwlbnjQ1+DBbSil1iV
        YPUokMNf8pAIjVjOMek6F/dR0Dd+K+MtyjrD2Ua0+B/W3kmZa47D0L1+09LZfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632571723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2B/DnmBtUTdcjfM1I8ybzwGAyOjG6d7ZfGM/cv0fB8=;
        b=GiWhD8eeRtvuZCs7HMXPcrsK+5wD7DWsSVEj54dK3+H3KTnPYjd58ntmrhReVT9hByTGvZ
        QabEZ4Ka3zSyrFDA==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
In-Reply-To: <87r1dedykm.ffs@tglx>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com> <87r1dedykm.ffs@tglx>
Date:   Sat, 25 Sep 2021 14:08:42 +0200
Message-ID: <87czoweu2d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 24 2021 at 13:04, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> +int uintr_receiver_wait(void)
>> +{
>> +	struct uintr_upid_ctx *upid_ctx;
>> +	unsigned long flags;
>> +
>> +	if (!is_uintr_receiver(current))
>> +		return -EOPNOTSUPP;
>> +
>> +	upid_ctx = current->thread.ui_recv->upid_ctx;
>> +	upid_ctx->upid->nc.nv = UINTR_KERNEL_VECTOR;
>> +	upid_ctx->waiting = true;
>> +	spin_lock_irqsave(&uintr_wait_lock, flags);
>> +	list_add(&upid_ctx->node, &uintr_wait_list);
>> +	spin_unlock_irqrestore(&uintr_wait_lock, flags);
>> +
>> +	set_current_state(TASK_INTERRUPTIBLE);
>
> Because we have not enough properly implemented wait primitives you need
> to open code one which is blantantly wrong vs. a concurrent wake up?
>
>> +	schedule();
>
> How is that correct vs. a spurious wakeup? What takes care that the
> entry is removed from the list?
>
> Again. We have proper wait primitives.

Aisde of that this is completely broken vs. CPU hotplug.

CPUX
  switchto(tsk)
    tsk->upid.ndst = apicid(smp_processor_id();

  ret_to_user()
  ...
  sys_uintr_wait()
    ...
    schedule()

After that CPU X is unplugged which means the task won't be woken up by
an user IPI which is issued after CPU X went down.

Thanks,

        tglx
