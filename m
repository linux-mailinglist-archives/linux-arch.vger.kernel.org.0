Return-Path: <linux-arch+bounces-1405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8114B832AD7
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 14:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E7A1C2442C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D95381A;
	Fri, 19 Jan 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SwhzfapH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7F53811;
	Fri, 19 Jan 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672621; cv=none; b=idpl+n8DsnIh5tbls+FYCVV7ccELA6buJwlzv+9gsbzTLVmItWU9lKvYh/KzhIuEDtvj+T5Q17VNYttbdOstm13g4TQs7lNpK6KV9lK4jj7Ip32VWTrhFjfeClraqdseEiMzr9z999Qe8D+Hb4C6Z2XMg8MQlwibER6fVXL+uJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672621; c=relaxed/simple;
	bh=Dzk81ME8LvQSamL1SNsZWxijV64H7yv3CiEQR/Wgfog=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=WM9exwHIWIRyXUArO4rJkD5NrwYaZnAzlFqn13TRjeGurxuIuJG5CqIu71m2QaN3CDiefJl6UpCJpBSgoazYCyeELZBX8WbgPPtulXWSDXCCmAt+LEkjg7Gv6jXb2fSjsFuVJeXNSiVvtCkBwwXUSIpUYyoiNordgYEN7cYfTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SwhzfapH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JDqjlg013770;
	Fri, 19 Jan 2024 13:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=pp1; bh=4yJ1PvlhKF5ebvPj66SGf04iGsGLKVD6KL8an/YURt4=;
 b=SwhzfapH2CJruLYlbjfqzI9nWYPgcRJJTaRXb0q/3r3xVnpWD9BU5b+39QWItCxadFkZ
 4+jQSFAs457HkKR44nSzxPfsp8Fqy2uRkAE0pcPaMRcBlGaBElcg42nfcvswb6wPkXGw
 XZ76Iv+/VroLTOPOFVeDfpF+f+RycD+oehmWGA+IAcl2rwqywMYG56wAhTZ/ffjQt0Sq
 83jbCaRcLlooLIGocIoNV+A1o2Hpv1IcCgmqSbZD7onoDnVDWuf3WklTNrVIgkwGZf/p
 MMTJxNTiGuIr9pgGpiOrK5EaP29rrQXHlUQqtd7A/ip6JpCcvIOGbTJWgGOXHit+ulAC wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqtbf02ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:56:17 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JDu55W025157;
	Fri, 19 Jan 2024 13:56:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqtbf02tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:56:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40JAfoWI009413;
	Fri, 19 Jan 2024 13:56:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5up1vhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:56:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40JDuCUU18285260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 13:56:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 340A32004B;
	Fri, 19 Jan 2024 13:56:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F61B20040;
	Fri, 19 Jan 2024 13:56:11 +0000 (GMT)
Received: from [9.171.41.26] (unknown [9.171.41.26])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jan 2024 13:56:11 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------efg6hB0FNWC65xkaiJmoB8uN"
Message-ID: <fc3fd07a-218d-406c-918b-e7f701968eb0@linux.ibm.com>
Date: Fri, 19 Jan 2024 14:56:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Cc: "xry111@xry111.site" <xry111@xry111.site>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
 <20231114154017.GI4779@noisy.programming.kicks-ass.net>
 <87ttpowajb.fsf@oldenburg.str.redhat.com>
 <20231114201402.GA25315@noisy.programming.kicks-ass.net>
 <822f3a867e5661ce61cea075a00ce04a4e4733f3.camel@intel.com>
 <20231115085102.GY3818@noisy.programming.kicks-ass.net>
 <564119521b61b5a38f9bdfe6c7a41fcbb07049c9.camel@intel.com>
 <158f6a47727a40c163e3fa6041a24388549c68f2.camel@intel.com>
From: Stefan Liebler <stli@linux.ibm.com>
In-Reply-To: <158f6a47727a40c163e3fa6041a24388549c68f2.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -eYrsRMX54MPeWXAppdYmCFuQVsAPpYK
X-Proofpoint-ORIG-GUID: S7FEZ5rPc-g0aukt1pdcD6Xvm8J5u36f
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401190074

This is a multi-part message in MIME format.
--------------efg6hB0FNWC65xkaiJmoB8uN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.11.23 02:22, Edgecombe, Rick P wrote:
> A bit more info...
> 
> The error returned to userspace is originating from:
> https://github.com/torvalds/linux/blob/master/kernel/futex/pi.c#L295
> 
> 'uval' is often zero in that error case, but sometimes just a
> mismatching value like: uval=0x567, task_pid_vnr()=0x564
> 
> 
> Depending on the number of CPUs the VM is running on it reproduces or
> not. When it does reproduce, the newly added path here is taken:
> https://github.com/torvalds/linux/blob/master/kernel/futex/pi.c#L1185
> The path is taken a lot during the test, sometimes >400 times before
> the above linked error is generated during the syscall. When it doesn't
> reproduce, I never saw that new path taken.
> 
> More print statements make the reproduction less reliable, so it does
> seem to have a race in the mix at least somewhat. Otherwise, I haven't
> tried to understand what is going on here with all this highwire
> locking.
> 
> Hope it helps.
Hi,

I've also observed fails in glibc testcase nptl/tst-robust8pi with:
mutex_timedlock of 66 in thread 7 failed with 22
=> pthread_mutex_timedlock returns 22=EINVAL

I've saw it on s390x. There I've used kernel with
commit 120d99901eb288f1d21db3976df4ba347b28f9c7
s390/vfio-ap: do not reset queue removed from host config

But I also saw it on a x86_64 kvm-guest with Fedora 39 and
copr-repository with vanilla kernel:
Linux fedora 6.7.0-0.rc8.20240107gt52b1853b.366.vanilla.fc39.x86_64 #1
SMP PREEMPT_DYNAMIC Sun Jan  7 06:17:30 UTC 2024 x86_64 GNU/Linux

And reported it to libc-alpha ("FAILING nptl/tst-robust8pi"
https://sourceware.org/pipermail/libc-alpha/2024-January/154150.html)
where Florian Weimer pointed me to this thread.

I've reduced the test (see attachement) and now have only one process
with three threads. I only use one mutex with attributes like the
original testcase: PTHREAD_MUTEX_ROBUST_NP, PTHREAD_PROCESS_SHARED,
PTHREAD_PRIO_INHERIT.
Every thread is doing a loop with pthread_mutex_timedlock(abstime={0,0})
and if locked, pthread_mutex_unlock.

I've added some uprobes before and after the futex-syscall in
__futex_lock_pi64(in pthread_mutex_timedlock) and futex_unlock_pi(in
pthread_mutex_unlock). For me __ASSUME_FUTEX_LOCK_PI2 is not available,
but __ASSUME_TIME64_SYSCALLS is defined.

For me it looks like this (simplified ubprobes-trace):
<thread> <timestamp>: <probe>
t1 4309589.419744: before syscall in __futex_lock_pi64

t3 4309589.419745: before syscall in futex_unlock_pi
t2 4309589.419745: before syscall in __futex_lock_pi64

t3 4309589.419747: after syscall in futex_unlock_pi
t2 4309589.419747: after syscall in __futex_lock_pi64 ret=-22=EINVAL

t1 4309589.419748: after syscall in __futex_lock_pi64 ret=-110=ETIMEDOUT

Can you please have a look again?

Bye,
Stefan Liebler
--------------efg6hB0FNWC65xkaiJmoB8uN
Content-Type: text/x-csrc; charset=UTF-8; name="tst-robust8pi-20240118.c"
Content-Disposition: attachment; filename="tst-robust8pi-20240118.c"
Content-Transfer-Encoding: base64

Ly9DRkxBR1M9LXB0aHJlYWQKLy9MREZMQUdTPS1scHRocmVhZAojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8
YXNzZXJ0Lmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CgojZGVm
aW5lIE5VTV9USFJFQURTIDMKI2RlZmluZSBUSFJFQURfRlVOQyB0aHJfZnVuYwojZGVmaW5l
IFVTRV9CQVJSSUVSIDEKI2lmbmRlZiBST1VORFMKIyBkZWZpbmUgUk9VTkRTIDEwMDAwMDAw
MAojZW5kaWYKCnR5cGVkZWYgc3RydWN0IHRocl9pbmZvCnsKICBpbnQgbnI7CiAgcHRocmVh
ZF90IHRocmVhZDsKfSBfX2F0dHJpYnV0ZV9fICgoYWxpZ25lZCAoMjU2KSkpIHRocl9pbmZv
X3Q7CgojZGVmaW5lIFRIUl9JTklUKCkJCQkJXAogIHRocl9pbmZvX3QgKnRociA9ICh0aHJf
aW5mb190ICopIGFyZzsKCiNkZWZpbmUgVEhSX1BSSU5URihmbXQsIC4uLikJCQlcCiAgcHJp
bnRmICgiIyVkOiAiIGZtdCwgdGhyLT5uciwgX19WQV9BUkdTX18pCgojZGVmaW5lIFRIUl9Q
VVRTKG1zZykJCQkJXAogIHByaW50ZiAoIiMlZDogIiBtc2cgIlxuIiwgdGhyLT5ucikKCiNp
ZiBVU0VfQkFSUklFUiAhPSAwCnN0YXRpYyBwdGhyZWFkX2JhcnJpZXJfdCB0aHJzX2JhcnJp
ZXI7CiNlbmRpZgoKc3RhdGljIHB0aHJlYWRfbXV0ZXhfdCBtdHg7CnN0YXRpYyBjb25zdCBz
dHJ1Y3QgdGltZXNwZWMgYmVmb3JlID0geyAwLCAwIH07CgovKiAjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiAg
IHRocmVhZCBmdW5jCiAgICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyAgKi8KCnN0YXRpYyB2b2lkICoKdGhyX2Z1bmMg
KHZvaWQgKmFyZykKewogIFRIUl9JTklUICgpOwogIGludCBzdGF0ZSA9IDA7CiAgaW50IGZj
dDsKCiNpZiAwCiAgLyogMyB0aHJlYWRzLCAxeGZjdD0wPXB0aHJlYWRfbXV0ZXhfbG9jaywg
MnhmY3Q9MT1wdGhyZWFkX211dGV4X3RpbWVkbG9jazogRUlOVkFMLiAgKi8KICBmY3QgPSAo
dGhyLT5uciArIDEpICUgMjsKI2VsaWYgMAogIC8qIDMgdGhyZWFkcywgMnhmY3Q9MD1wdGhy
ZWFkX211dGV4X2xvY2ssIDF4ZmN0PTE9cHRocmVhZF9tdXRleF90aW1lZGxvY2s6IG5vIGZh
aWxzLiAgKi8KICBmY3QgPSAodGhyLT5ucikgJSAyOwojZWxpZiAxCiAgLyogPjMgdGhyZWFk
cywgZmN0PTE9b25seSBwdGhyZWFkX211dGV4X3RpbWVkbG9jazogRUlOVkFMLiAgKi8KICBm
Y3QgPSAxOwojZW5kaWYKCiAgaW50IHJvdW5kID0gMDsKICBUSFJfUFJJTlRGICgic3RhcnRl
ZDogZmN0PSVkXG4iLCBmY3QpOwojaWYgVVNFX0JBUlJJRVIgIT0gMAogIHB0aHJlYWRfYmFy
cmllcl93YWl0ICgmdGhyc19iYXJyaWVyKTsKI2VuZGlmCiAgd2hpbGUgKDEpCiAgICB7Cgog
ICAgICBpZiAoc3RhdGUgPT0gMCkKCXsKCSAgcm91bmQgKys7CgkgIGludCBlOwoKCSAgc3dp
dGNoIChmY3QpCgkgICAgewoJICAgIGNhc2UgMDoKCSAgICAgIGUgPSBwdGhyZWFkX211dGV4
X2xvY2sgKCZtdHgpOwoJICAgICAgaWYgKGUgIT0gMCkKCQl7CgkJICBUSFJfUFJJTlRGICgi
bXV0ZXhfbG9jayBmYWlsZWQgd2l0aCAlZCAocm91bmQ9JWQpXG4iLCBlLCByb3VuZCk7CgkJ
ICBleGl0ICgxKTsKCQl9CgkgICAgICBzdGF0ZSA9IDE7CgkgICAgICBicmVhazsKCSAgICBj
YXNlIDE6CgkgICAgICBlID0gcHRocmVhZF9tdXRleF90aW1lZGxvY2sgKCZtdHgsICZiZWZv
cmUpOwoJICAgICAgaWYgKGUgIT0gMCAmJiBlICE9IEVUSU1FRE9VVCkKCQl7CgkJICBUSFJf
UFJJTlRGICgibXV0ZXhfdGltZWRsb2NrIGZhaWxlZCB3aXRoICVkIChyb3VuZD0lZClcbiIs
IGUsIHJvdW5kKTsKCQkgIGV4aXQgKDEpOwoJCX0KCSAgICAgIGJyZWFrOwoJICAgIGRlZmF1
bHQ6CgkgICAgICBlID0gcHRocmVhZF9tdXRleF90cnlsb2NrICgmbXR4KTsKCSAgICAgIGlm
IChlICE9IDAgJiYgZSAhPSBFQlVTWSkKCQl7CgkJICBUSFJfUFJJTlRGICgibXV0ZXhfdHJ5
bG9jayBmYWlsZWQgd2l0aCAlZCAocm91bmQ9JWQpXG4iLCBlLCByb3VuZCk7CgkJICBleGl0
ICgxKTsKCQl9CgkgICAgICBicmVhazsKCSAgICB9CgoJICBpZiAoZSA9PSBFT1dORVJERUFE
KQoJICAgIHB0aHJlYWRfbXV0ZXhfY29uc2lzdGVudCAoJm10eCk7CgoJICBpZiAoZSA9PSAw
IHx8IGUgPT0gRU9XTkVSREVBRCkKCSAgICBzdGF0ZSA9IDE7Cgl9CiAgICAgIGVsc2UKCXsK
CSAgaW50IGUgPSBwdGhyZWFkX211dGV4X3VubG9jayAoJm10eCk7CgkgIGlmIChlICE9IDAp
CgkgICAgewoJICAgICAgVEhSX1BSSU5URiAoIm11dGV4X3VubG9jayBvZiBmYWlsZWQgd2l0
aCAlZCAocm91bmQ9JWQpXG4iLCBlLCByb3VuZCk7CgkgICAgICBleGl0ICgxKTsKCSAgICB9
CgkgIHN0YXRlID0gMDsKCX0KCiAgICAgIGlmIChyb3VuZCA+PSBST1VORFMpCgl7CgkgIFRI
Ul9QUklOVEYgKCJSRUFDSEVEIHJvdW5kICVkLiA9PiBleGl0XG4iLCBST1VORFMpOwoJICBp
ZiAoc3RhdGUgIT0gMCkKCSAgICB7CgkgICAgICBpbnQgZSA9IHB0aHJlYWRfbXV0ZXhfdW5s
b2NrICgmbXR4KTsKCSAgICAgIGlmIChlICE9IDApCgkJewoJCSAgVEhSX1BSSU5URiAoIm11
dGV4X3VubG9ja0BleGl0IG9mIGZhaWxlZCB3aXRoICVkIChyb3VuZD0lZClcbiIsIGUsIHJv
dW5kKTsKCQkgIGV4aXQgKDEpOwoJCX0KCSAgICB9CgkgIGJyZWFrOwoJfQogICAgfQoKICBy
ZXR1cm4gTlVMTDsKfQoKaW50Cm1haW4gKHZvaWQpCnsKICBpbnQgaTsKICBwcmludGYgKCJt
YWluOiBzdGFydCAlZCB0aHJlYWRzLlxuIiwgTlVNX1RIUkVBRFMpOwoKI2lmIFVTRV9CQVJS
SUVSICE9IDAKICBwdGhyZWFkX2JhcnJpZXJfaW5pdCAoJnRocnNfYmFycmllciwgTlVMTCwg
TlVNX1RIUkVBRFMgKyAxKTsKI2VuZGlmCgogIHB0aHJlYWRfbXV0ZXhhdHRyX3QgbWE7CiAg
aWYgKHB0aHJlYWRfbXV0ZXhhdHRyX2luaXQgKCZtYSkgIT0gMCkKICAgIHsKICAgICAgcHV0
cyAoIm11dGV4YXR0cl9pbml0IGZhaWxlZCIpOwogICAgICByZXR1cm4gMDsKICAgIH0KICBp
ZiAocHRocmVhZF9tdXRleGF0dHJfc2V0cm9idXN0ICgmbWEsIFBUSFJFQURfTVVURVhfUk9C
VVNUX05QKSAhPSAwKQogICAgewogICAgICBwdXRzICgibXV0ZXhhdHRyX3NldHJvYnVzdCBm
YWlsZWQiKTsKICAgICAgcmV0dXJuIDE7CiAgICB9CiAgaWYgKHB0aHJlYWRfbXV0ZXhhdHRy
X3NldHBzaGFyZWQgKCZtYSwgUFRIUkVBRF9QUk9DRVNTX1NIQVJFRCkgIT0gMCkKICAgIHsK
ICAgICAgcHV0cyAoIm11dGV4YXR0cl9zZXRwc2hhcmVkIGZhaWxlZCIpOwogICAgICByZXR1
cm4gMTsKICAgIH0KICBpZiAocHRocmVhZF9tdXRleGF0dHJfc2V0cHJvdG9jb2wgKCZtYSwg
UFRIUkVBRF9QUklPX0lOSEVSSVQpICE9IDApCiAgICB7CiAgICAgIHB1dHMgKCJwdGhyZWFk
X211dGV4YXR0cl9zZXRwcm90b2NvbCBmYWlsZWQiKTsKICAgICAgcmV0dXJuIDE7CiAgICB9
CgogIGlmIChwdGhyZWFkX211dGV4X2luaXQgKCZtdHgsICZtYSkgIT0gMCkKICAgIHsKICAg
ICAgcHV0cyAoInB0aHJlYWRfbXV0ZXhfaW5pdCBmYWlsZWQiKTsKICAgICAgcmV0dXJuIDE7
CiAgICB9CgogIHRocl9pbmZvX3QgdGhyc1tOVU1fVEhSRUFEU107CiAgZm9yIChpID0gMDsg
aSA8IE5VTV9USFJFQURTOyBpKyspCiAgICB7CiAgICAgIHRocnNbaV0ubnIgPSBpOwogICAg
ICBhc3NlcnQgKHB0aHJlYWRfY3JlYXRlICgmKHRocnNbaV0udGhyZWFkKSwgTlVMTCwgVEhS
RUFEX0ZVTkMsICYodGhyc1tpXSkpCgkgICAgICA9PSAwKTs7CiAgICB9CgojaWYgVVNFX0JB
UlJJRVIgIT0gMAogIC8qIEFsbCB0aHJlYWRzIHN0YXJ0IHdvcmsgYWZ0ZXIgdGhpcyBiYXJy
aWVyLiAgKi8KICBwdGhyZWFkX2JhcnJpZXJfd2FpdCAoJnRocnNfYmFycmllcik7CiNlbmRp
ZgoKICBmb3IgKGkgPSAwOyBpIDwgTlVNX1RIUkVBRFM7IGkrKykKICAgIHsKICAgICAgcHRo
cmVhZF9qb2luICh0aHJzW2ldLnRocmVhZCwgTlVMTCk7CiAgICB9CgojaWYgVVNFX0JBUlJJ
RVIgIT0gMAogIHB0aHJlYWRfYmFycmllcl9kZXN0cm95ICgmdGhyc19iYXJyaWVyKTsKI2Vu
ZGlmCgogIHByaW50ZiAoIm1haW46IGVuZC5cbiIpOwogIHJldHVybiBFWElUX1NVQ0NFU1M7
Cn0K

--------------efg6hB0FNWC65xkaiJmoB8uN--


