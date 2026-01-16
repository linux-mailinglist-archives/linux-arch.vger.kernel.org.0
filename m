Return-Path: <linux-arch+bounces-15835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3CD38410
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D4BF300DD96
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138B130BB84;
	Fri, 16 Jan 2026 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cs7PBOLt"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABB20DD52;
	Fri, 16 Jan 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587343; cv=none; b=W+H+l9dSDV3uxN+iMHb5tkfUM0/JKtUVuetYJYWkyNOXmFGsyPP9ecwbwtUDeDIQujZux/8lJNPTq7lTEjfnVU82NBY1LkDEvsnKNmD7Vz4BlMtOQZCr6wEHWVFiCGbHqFV69ODLkAhqQ3F2QBN0X8yne1gLjBSYmzjRJAVgkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587343; c=relaxed/simple;
	bh=3elgxiHACKDBitrBObrxyEWGvTPgqAc7y8QNn1NYMag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YajX8ebWuFNedzlHCI7NXiqIfv+oiygS1x7JJbOKZ7qNft6jME/Yk/N4no0iDV2JECNbo7B6JP5Kds1zmbYrBpKf5IdMljsmWCm+Xa/p5pMBPAa2ZY3+LMaTLn7uiJ4RilkqK75CEanF4h7etJSLhkgJLNxRtKe/M0UL+iJDcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cs7PBOLt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iFRUEbtTO4CTH3fghj5jx8JZL5tIwEPOPsjlae/900Q=; b=Cs7PBOLt9CblvsGqVT9MaVmOzs
	0Z4dieqMXfDgDGl2QC7xseIpBlVG+Dj6basiwlfYCgMdaZbaNehvdz4VHXmtrA9DWy5lcUgPSRASo
	+2p8PwvCd87UxGQYjs0NlIKSYRF/aw/EsB2zo4DATNzlC8D/Dt1myulKFBLQR3B21dfYRvYJyP5XI
	GGR0/o1sorHDwOuWICUdCgty5dK2+OHZk9yhwHptte5gWI5e2bAtOx73162bUJRUq3rwpaXPDRUTS
	YFqsvWCZFCQeXcCgyfvtlDOZA42UP5jpR32F3l2gdv1OUpz6aML+RHnwu1++/rq7Ul7Y9SowBk2fX
	wzZKCUlA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgoM2-00000009hqp-01Mb;
	Fri, 16 Jan 2026 18:15:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7AC443005E5; Fri, 16 Jan 2026 19:15:24 +0100 (CET)
Date: Fri, 16 Jan 2026 19:15:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension
 enforcement timer
Message-ID: <20260116181524.GF831285@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20251218150524.GY3707837@noisy.programming.kicks-ass.net>
 <87ecorbccp.ffs@tglx>
 <20251219100517.GA1132199@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219100517.GA1132199@noisy.programming.kicks-ass.net>

On Fri, Dec 19, 2025 at 11:05:17AM +0100, Peter Zijlstra wrote:

> I was thinking that perhaps the hrtimer tracepoints, filtered on this
> specific timer, might just do. Arming the timer is the point where the
> extension is granted, cancelling the timer is on the slice_yield() (or
> any other random syscall :/), and the timer actually firing is on fail.

Here, I google pasted this together. I don't actually speak much snake
(as you well know). Nor does it fully work; the handle_expire() thing is
busted, I definitely have expire entries in the trace, but they're not
showing up.

$ trace-cmd record -e hrtimer_start -e hrtimer_cancel -e hrtimer_expire_entry -- ./slice_test
$ ./foo.py

========================================
RSEQ SLICE HISTOGRAM (us)
========================================

Task: slice_test    Mean: 375.577 ns
  Latency (us)    | Count
  ------------------------------
  0 us            | 142031
  1 us            | 292
  2 us            | 67
  3 us            | 33
  4 us            | 34
  5 us            | 27
  6 us            | 15
  7 us            | 14
  8 us            | 24
  9 us            | 33
  10 us           | 691


---
#!/usr/bin/python3

#
# trace-cmd record -e hrtimer_start -e hrtimer_cancel -e hrtimer_expire_entry -- $cmd
#

from tracecmd import *

def load_kallsyms(file_path='/proc/kallsyms'):
    """
    Parses /proc/kallsyms into a dictionary.
    Returns: { address_int: symbol_name }
    """
    kallsyms_map = {}

    try:
        with open(file_path, 'r') as f:
            for line in f:
                # The format is: [address] [type] [name] [module]
                parts = line.split()
                if len(parts) < 3:
                    continue

                addr = int(parts[0], 16)
                name = parts[2]

                kallsyms_map[addr] = name

    except PermissionError:
        print(f"Error: Permission denied reading {file_path}. Try running with sudo.")
    except FileNotFoundError:
        print(f"Error: {file_path} not found.")

    return kallsyms_map

ksyms = load_kallsyms()

# pending[timer_ptr] = {'ts': timestamp, 'comm': comm}
pending = {}

# histograms[comm][bucket] = count
histograms = {}

class OnlineHarmonicMean:
    def __init__(self):
        self.n = 0          # Count of elements
        self.S = 0.0        # Cumulative sum of reciprocals

    def update(self, x):
        if x == 0:
            raise ValueError("Harmonic mean is undefined for zero.")

        self.n += 1
        self.S += 1.0 / x
        return self.n / self.S

    @property
    def mean(self):
        return self.n / self.S if self.n > 0 else 0

ohms = {}

def handle_start(record):
    func_name = ksyms[record.num_field("function")]
    if "rseq_slice_expired" in func_name:
        timer_ptr = record.num_field("hrtimer")
        pending[timer_ptr] = {
            'ts': record.ts,
            'comm': record.comm
        }
    return None 

def handle_cancel(record):
    timer_ptr = record.num_field("hrtimer")
    
    if timer_ptr in pending:
        start_data = pending.pop(timer_ptr)
        duration_ns = record.ts - start_data['ts']
        duration_us = duration_ns // 1000

        comm = start_data['comm']

        if comm not in ohms:
            ohms[comm] = OnlineHarmonicMean()

        ohms[comm].update(duration_ns)
        
        if comm not in histograms:
            histograms[comm] = {}
        
        histograms[comm][duration_us] = histograms[comm].get(duration_us, 0) + 1
    return None

def handle_expire(record):
    timer_ptr = record.num_field("hrtimer")

    if timer_ptr in pending:
        start_data = pending.pop(timer_ptr)
        comm = start_data['comm']
        
        if comm not in histograms:
            histograms[comm] = {}
            
        # Record -1 bucket for expired (failed to cancel)
        histograms[comm][-1] = histograms[comm].get(-1, 0) + 1
    return None

if __name__ == "__main__":
    t = Trace("trace.dat")
    for cpu in range(0, t.cpus):
        ev = t.read_event(cpu)
        while ev:
            if "hrtimer_start" in ev.name:
                handle_start(ev)
            if "hrtimer_cancel" in ev.name:
                handle_cancel(ev)
            if "hrtimer_expire_entry" in ev.name:
                handle_expire(ev)

            ev = t.read_event(cpu)

    print("\n" + "="*40)
    print("RSEQ SLICE HISTOGRAM (us)")
    print("="*40)
    for comm, buckets in histograms.items():
        print(f"\nTask: {comm}    Mean: {ohms[comm].mean:.3f} ns")
        print(f"  {'Latency (us)':<15} | {'Count'}")
        print(f"  {'-'*30}")
        # Sort buckets numerically, putting -1 at the top
        for bucket in sorted(buckets.keys()):
            label = "EXPIRED" if bucket == -1 else f"{bucket} us"
            print(f"  {label:<15} | {buckets[bucket]}")

