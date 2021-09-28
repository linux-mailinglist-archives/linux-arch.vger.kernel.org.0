Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72C341AA77
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbhI1IN1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 04:13:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhI1IN0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Sep 2021 04:13:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632816706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MuA+W1hIA1rAMXQIqohvtqkn6nT1tdEByWW7so2/mJE=;
        b=o4AnzY92TDieIgsy0BxYM5ZrB7EKL02pFUFM6LcB4FFSjyx/IoknxzoYCwx61/g49g1LW9
        K6ODGpL2PzQRXYgEhGdPzWWs/0oZKiBxLNrfe7Vf75kdG+hFBCC9oIUPDD4Z3KmMuxxn2z
        Eg4wnTUmdqDlGRQ9761Xg/RubHl4bDgobqZFuEimIakTgiYXKDfnsZ7HDISSL4gSa4q4ni
        WhxbEGAaexob8STeYYdPQ1VURR2ErZWrmiBRLAY6VVshAZAENbVuJrWbK11ilMwSQ2Y/uF
        5qZWAPY1vXTkeOvt8isNigKPsNXfir2Zi9EpdZDuxDjOHZAqQht0UjX0xxs+bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632816706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MuA+W1hIA1rAMXQIqohvtqkn6nT1tdEByWW7so2/mJE=;
        b=l8vTUOns3NZZW+RgVuFEifsZxru0n8deKjPocVe7Z5Jbqqa5HK5OCRpnvmZ2yuboQGYauN
        090YSxHuWDSQ8PAw==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
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
Subject: Re: [RFC PATCH 05/13] x86/irq: Reserve a user IPI notification vector
In-Reply-To: <447377f0-21e5-067d-55ac-cb2eeca7ceae@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-6-sohil.mehta@intel.com> <87fstugabg.ffs@tglx>
 <878rzkeq9f.ffs@tglx> <87bl4fcxz8.ffs@tglx>
 <447377f0-21e5-067d-55ac-cb2eeca7ceae@intel.com>
Date:   Tue, 28 Sep 2021 10:11:45 +0200
Message-ID: <878rzhazlq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sohil,

On Mon, Sep 27 2021 at 12:07, Sohil Mehta wrote:
> On 9/26/2021 5:39 AM, Thomas Gleixner wrote:
>
> The User-interrupt notification processing moves all the pending 
> interrupts from UPID.PIR to the UIRR.

Indeed that makes sense. Should have thought about that myself.

>> Also the restore portion on the way back to user space has to be coupled
>> more tightly:
>>
>> arch_exit_to_user_mode_prepare()
>> {
>>          ...
>>          if (unlikely(ti_work & _TIF_UPID))
>>          	uintr_restore_upid(ti_work & _TIF_NEED_FPU_LOAD);
>>          if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
>>          	switch_fpu_return();
>> }
>
> I am assuming _TIF_UPID would be set everytime SN is set and XSTATE is 
> saved.

Yes.

>> upid_set_ndst(upid)
>> {
>> 	apicid = __this_cpu_read(x86_cpu_to_apicid);
>>
>>          if (x2apic_enabled())
>>              upid->ndst.x2apic = apicid;
>>          else
>>              upid->ndst.apic = apicid;
>> }
>>
>> uintr_restore_upid(bool xrstors_pending)
>> {
>>          clear_thread_flag(TIF_UPID);
>>          
>> 	// Update destination
>>          upid_set_ndst(upid);
>>
>>          // Do we need something stronger here?
>>          barrier();
>>
>>          clear_bit(SN, upid->status);
>>
>>          // Any SENDUIPI after this point sends to this CPU
>>             
>>          // Any bit which was set in upid->pir after SN was set
>>          // and/or UINV was cleared by XSAVES up to the point
>>          // where SN was cleared above is not reflected in UIRR.
>>
>> 	// As this runs with interrupts disabled the current state
>>          // of upid->pir can be read and used for restore. A SENDUIPI
>>          // which sets a bit in upid->pir after that read will send
>>          // the notification vector which is going to be handled once
>>          // the task reenables interrupts on return to user space.
>>          // If the SENDUIPI set the bit before the read then the
>>          // notification vector handling will just observe the same
>>          // PIR state.
>>
>>          // Needs to be a locked access as there might be a
>>          // concurrent SENDUIPI modiying it.
>>          pir = read_locked(upid->pir);
>>
>>          if (xrstors_pending)) {
>>          	// Update the saved xstate for xrstors
>>             	current->xstate.uintr.uinv = UINTR_NOTIFICATION_VECTOR;
>
> XSAVES saves the UINV value into the XSTATE buffer. I am not sure if we 
> need this again. Is it because it could have been overwritten by calling 
> XSAVES twice?

Yes that can happen AFAICT. I haven't done a deep analysis, but this
needs to looked at.

>>                  current->xstate.uintr.uirr = pir;
>
> I believe PIR should be ORed. There could be some bits already set in 
> the UIRR.
>
> Also, shouldn't UPID->PIR be cleared? If not, we would detect these 
> interrupts all over again during the next ring transition.

Right. So that PIR read above needs to be a locked cmpxchg().

>>          } else {
>>                  // Manually restore UIRR and UINV
>>                  wrmsrl(IA32_UINTR_RR, pir);
> I believe read-modify-write here as well.

Sigh, yes.

Thanks,

        tglx
