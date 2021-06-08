Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78B63A07DA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhFHXkM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 19:40:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:25117 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234187AbhFHXkM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 19:40:12 -0400
IronPort-SDR: PhVfYU3yM+kKGfCbOtWah/c4y+TTHybZCU1QC/l4xGNJS9Tsdqv4F+Y9vh4yf7pt76JsfAyJ2U
 O3AYQrc9uweQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="203113719"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="203113719"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:38:16 -0700
IronPort-SDR: pE4bdvjF0J9Yr2v3Y5b0EYAhXyF61Gs96zOXtSka7ND8veuaNykb0Auifm2a4kdYM6xKQUkwk/
 irwRg3JJ0msA==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="551784529"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:38:15 -0700
Subject: Re: [PATCH v8 0/8] Fork brute force attack mitigation
To:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20210605150405.6936-1-john.wood@gmx.com>
 <202106081616.EC17DC1D0D@keescook>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <cbfd306b-6e37-a697-ebdb-4a5029d36583@linux.intel.com>
Date:   Tue, 8 Jun 2021 16:38:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <202106081616.EC17DC1D0D@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 6/8/2021 4:19 PM, Kees Cook wrote:
> On Sat, Jun 05, 2021 at 05:03:57PM +0200, John Wood wrote:
>> [...]
>> the kselftest to avoid the detection ;) ). So, in this version, to track
>> all the statistical data (info related with application crashes), the
>> extended attributes feature for the executable files are used. The xattr is
>> also used to mark the executables as "not allowed" when an attack is
>> detected. Then, the execve system call rely on this flag to avoid following
>> executions of this file.
> I have some concerns about this being actually usable and not creating
> DoS situations. For example, let's say an attacker had found a hard-to-hit
> bug in "sudo", and starts brute forcing it. When the brute LSM notices,
> it'll make "sudo" unusable for the entire system, yes?
>
> And a reboot won't fix it, either, IIUC.
>
The whole point of the mitigation is to trade potential attacks against DOS.

If you're worried about DOS the whole thing is not for you.

-Andi



