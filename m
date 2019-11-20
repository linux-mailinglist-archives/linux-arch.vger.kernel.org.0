Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7910450D
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 21:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKTU3J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 15:29:09 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49718 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKTU3I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2019 15:29:08 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1iXWb4-0007Q3-GX; Wed, 20 Nov 2019 13:29:06 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iXWb4-0004NJ-8d; Wed, 20 Nov 2019 13:29:06 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Will Deacon <will@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org, ben.dooks@codethink.co.uk
References: <20191118145114.GA9228@avx2>
        <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
        <20191118215227.GA24536@avx2> <20191120191752.GC4799@willie-the-truck>
Date:   Wed, 20 Nov 2019 14:28:37 -0600
In-Reply-To: <20191120191752.GC4799@willie-the-truck> (Will Deacon's message
        of "Wed, 20 Nov 2019 19:17:52 +0000")
Message-ID: <87d0dm47ii.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iXWb4-0004NJ-8d;;;mid=<87d0dm47ii.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+83lFIyA5hg1F570AKpaOgIP+SI2XVCJc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMSubLong,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3454]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Will Deacon <will@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 332 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.9%), b_tie_ro: 1.99 (0.6%), parse: 0.81
        (0.2%), extract_message_metadata: 11 (3.4%), get_uri_detail_list: 1.82
        (0.5%), tests_pri_-1000: 8 (2.4%), tests_pri_-950: 1.29 (0.4%),
        tests_pri_-900: 1.06 (0.3%), tests_pri_-90: 25 (7.6%), check_bayes: 24
        (7.1%), b_tokenize: 7 (2.2%), b_tok_get_all: 8 (2.5%), b_comp_prob:
        2.6 (0.8%), b_tok_touch_all: 3.6 (1.1%), b_finish: 0.57 (0.2%),
        tests_pri_0: 269 (81.0%), check_dkim_signature: 0.50 (0.2%),
        check_dkim_adsp: 6 (1.9%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: warn if process starts with executable stack
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Will Deacon <will@kernel.org> writes:

> On Tue, Nov 19, 2019 at 12:52:27AM +0300, Alexey Dobriyan wrote:
>> There were few episodes of silent downgrade to an executable stack:
>> 
>> 1) linking innocent looking assembly file
>> 
>> 	$ cat f.S
>> 	.intel_syntax noprefix
>> 	.text
>> 	.globl f
>> 	f:
>> 	        ret
>> 
>> 	$ cat main.c
>> 	void f(void);
>> 	int main(void)
>> 	{
>> 	        f();
>> 	        return 0;
>> 	}
>> 
>> 	$ gcc main.c f.S
>> 	$ readelf -l ./a.out
>> 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>>                          0x0000000000000000 0x0000000000000000  RWE    0x10
>> 
>> 2) converting C99 nested function into a closure
>> https://nullprogram.com/blog/2019/11/15/
>> 
>> 	void intsort2(int *base, size_t nmemb, _Bool invert)
>> 	{
>> 	    int cmp(const void *a, const void *b)
>> 	    {
>> 	        int r = *(int *)a - *(int *)b;
>> 	        return invert ? -r : r;
>> 	    }
>> 	    qsort(base, nmemb, sizeof(*base), cmp);
>> 	}
>> 
>> will silently require stack trampolines while non-closure version will not.
>> 
>> While without a double this behaviour is documented somewhere, add a warning
>> so that developers and users can at least notice. After so many years of x86_64
>> having proper executable stack support it should not cause too much problems.
>> 
>> If the system is old or CPU is old, then there will be an early warning
>> against init and/or support personnel will write that "uh-oh, our Enterprise
>> Software absolutely requires executable stack" and close tickets and customers
>> will nod heads and life moves on.
>> 
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>> ---
>> 
>>  fs/exec.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -762,6 +762,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
>>  		goto out_unlock;
>>  	BUG_ON(prev != vma);
>>  
>> +	if (vm_flags & VM_EXEC) {
>> +		pr_warn_once("process '%s'/%u started with executable stack\n",
>> +			     current->comm, current->pid);
>> +	}
>
> Given that this is triggerable by userspace, is there a concern about PID
> namespaces here?

In what sense?  Are you thinking about the printing of the pid?

Pretty much by fiat and by definition the kernel log always print things
in the initial pid namespace.  Which this printk does.

Eric
