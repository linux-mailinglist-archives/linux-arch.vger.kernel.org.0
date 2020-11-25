Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB42C47FD
	for <lists+linux-arch@lfdr.de>; Wed, 25 Nov 2020 19:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgKYS5X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Nov 2020 13:57:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54780 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgKYS5X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Nov 2020 13:57:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APIn1As047055;
        Wed, 25 Nov 2020 18:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type;
 s=corp-2020-01-29; bh=dMqyVfNjNyfqDeIgOq6+WJodQ+S1PpHx5qQysEfXqEM=;
 b=Xmd1uXYNGqd9omF9s0vHoUGtnMMHf4r6wHj3CNsldX8QGXM8r2QbjDtFPPeSVolmsLZg
 PFbvpyPLUFzeyZ7fK3AzUXiKS8ytyg5PPKxQC/kq272dGJ3DcbBOXUrPBzx7qVeJXz3s
 e3BKbm8sIPQI+mG8CkEY3IYLbmjDaCn0OxYrrbbpW9Cd7UhYsQHEA1xCcawYT9wiPoaq
 h3JNu21Qj3vKJii+zJ/yaWPEdZJcAV9YtycYZUmHK2vcDOsYi3czfhQTOiGphMP5KdIc
 6Hxfn7HpHOjlru8oj+nFAgU8Xrnv+GH+47tGEFBKul0fwL7S4R7Hp58AUULl4VAYlCQn Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 351kwhayyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 18:56:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APItikt137407;
        Wed, 25 Nov 2020 18:56:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 351kwemsjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 18:56:19 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0APIu1h1022890;
        Wed, 25 Nov 2020 18:56:01 GMT
MIME-Version: 1.0
Message-ID: <8f10e63f-c95a-4771-b215-12e2b263d083@default>
Date:   Wed, 25 Nov 2020 10:56:01 -0800 (PST)
From:   Alex Kogan <alex.kogan@oracle.com>
To:     <oliver.sang@intel.com>
Cc:     <tglx@linutronix.de>, <lkp@lists.01.org>, <ying.huang@intel.com>,
        <lkp@intel.com>, <linux@armlinux.org.uk>, <feng.tang@intel.com>,
        <hpa@zytor.com>, <dave.dice@oracle.com>, <mingo@redhat.com>,
        <will.deacon@arm.com>, <arnd@arndb.de>, <jglauber@marvell.com>,
        <guohanjun@huawei.com>, <x86@kernel.org>,
        <zhengjun.xing@intel.com>, <daniel.m.jordan@oracle.com>,
        <steven.sistare@oracle.com>, <bp@alien8.de>,
        <linux-arm-kernel@lists.infradead.org>, <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [locking/qspinlock]  6f9a39a437:  unixbench.score -17.3%
 regression
X-Mailer: Zimbra on Oracle Beehive
Content-Type: multipart/mixed;
 boundary="__1606330561723405157abhmp0020.oracle.com"
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9816 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9816 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 impostorscore=0
 suspectscore=1 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250116
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--__1606330561723405157abhmp0020.oracle.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Oliver, thank you for this report.

All, with nr_task=3D30%, the benchmark hits the sweet spot on the contentio=
n curve=20
amplifying the overhead of shuffling threads between waiting queues without=
=20
reaping the locality overhead. I was able to reproduce the regression on ou=
r=20
machine, though to a lesser extent of about 10% of the performance drop for=
=20
the given test.

Luckily, we have a solution for this exact scenario, which we call the=20
shuffle reduction optimization, or SRO. It was a part of the series until v=
9,=20
but since it did not provide much benefit in my benchmarks in v10, it was=
=20
dropped. Now, with SRO, the regression on unixbench shrinks to about 1%,=20
while other performance numbers do not change much.

I attach the SRO patch here. IMHO, it is pretty straight-forward.=20
It uses randomization, but only to throttle the creation of a secondary que=
ue.
In particular, it does not introduce any extra delays for threads waiting
in that queue once it is created.

Anyway, any feedback is welcome!
Unless I hear any objections, I will plan to post another version of the se=
ries=20
with SRO included.

Thanks,
-- Alex

----- Original Message -----
From: oliver.sang@intel.com
To: alex.kogan@oracle.com
Cc: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.dea=
con@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,=
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@l=
inutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei=
.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@orac=
le.com, alex.kogan@oracle.com, dave.dice@oracle.com, lkp@intel.com, lkp@lis=
ts.01.org, ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.c=
om
Sent: Sunday, November 22, 2020 4:33:52 AM GMT -05:00 US/Canada Eastern
Subject: [locking/qspinlock]  6f9a39a437:  unixbench.score -17.3% regressio=
n


Greeting,

FYI, we noticed a -17.3% regression of unixbench.score due to commit:


commit: 6f9a39a4372e37907ac1fc7ede6c90932a88d174 ("[PATCH v12 5/5] locking/=
qspinlock: Avoid moving certain threads between waiting queues in CNA")
url: https://urldefense.com/v3/__https://github.com/0day-ci/linux/commits/A=
lex-Kogan/Add-NUMA-awareness-to-qspinlock/20201118-072506__;!!GqivPVa7Brio!=
J6uFF5neDgzw1T5v2mMXBTe1dyDbcWqAn9mi-YuDyYUiT8W303JqK82CZiGJB2Kl$=20
base: https://urldefense.com/v3/__https://git.kernel.org/cgit/linux/kernel/=
git/tip/tip.git__;!!GqivPVa7Brio!J6uFF5neDgzw1T5v2mMXBTe1dyDbcWqAn9mi-YuDyY=
UiT8W303JqK82CZn0AlnmE$  932f8c64d38bb08f69c8c26a2216ba0c36c6daa8

in testcase: unixbench
on test machine: 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
with following parameters:

=09runtime: 300s
=09nr_task: 30%
=09test: context1
=09cpufreq_governor: performance
=09ucode: 0x4003003

test-description: UnixBench is the original BYTE UNIX benchmark suite aims =
to test performance of Unix-like system.
test-url: https://urldefense.com/v3/__https://github.com/kdlucas/byte-unixb=
ench__;!!GqivPVa7Brio!J6uFF5neDgzw1T5v2mMXBTe1dyDbcWqAn9mi-YuDyYUiT8W303JqK=
82CZlLfqDIS$=20



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
---------------------------------------------------------------------------=
----------------------->


To reproduce:

        git clone https://urldefense.com/v3/__https://github.com/intel/lkp-=
tests.git__;!!GqivPVa7Brio!J6uFF5neDgzw1T5v2mMXBTe1dyDbcWqAn9mi-YuDyYUiT8W3=
03JqK82CZjvM7lRy$=20
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/te=
stcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/30%/debian-10.4-x86_64-20200603.cgz/300=
s/lkp-csl-2sp4/context1/unixbench/0x4003003

commit:=20
  eaf522d564 ("locking/qspinlock: Introduce starvation avoidance into CNA")
  6f9a39a437 ("locking/qspinlock: Avoid moving certain threads between wait=
ing queues in CNA")

eaf522d56432e0e5 6f9a39a4372e37907ac1fc7ede6=20
---------------- ---------------------------=20
         %stddev     %change         %stddev
             \          |                \ =20
      3715           -17.3%       3070        unixbench.score
     11584           +13.2%      13118        unixbench.time.involuntary_co=
ntext_switches
      1830            +4.7%       1916        unixbench.time.percent_of_cpu=
_this_job_got
      7012            +5.1%       7373        unixbench.time.system_time
    141.44           -15.6%     119.37        unixbench.time.user_time
 4.338e+08           -16.4%  3.627e+08        unixbench.time.voluntary_cont=
ext_switches
 5.807e+08           -17.5%  4.793e+08        unixbench.workload
    139.00 =C2=B1 67%     -71.0%      40.25        numa-vmstat.node1.nr_mlo=
ck
      1.08            -0.1        0.94        mpstat.cpu.all.irq%
      0.48 =C2=B1  2%      -0.1        0.40        mpstat.cpu.all.usr%
    956143 =C2=B1  7%     +11.0%    1060959 =C2=B1  3%  numa-meminfo.node0.=
MemUsed
   1185909 =C2=B1  5%      -8.8%    1081277 =C2=B1  3%  numa-meminfo.node1.=
MemUsed
   4402315           -16.3%    3682692        vmstat.system.cs
    235535            -4.6%     224625        vmstat.system.in
  6.42e+09           +16.4%  7.471e+09        cpuidle.C1.time
 1.941e+10 =C2=B1  7%     -20.0%  1.553e+10 =C2=B1 21%  cpuidle.C1E.time
  94497227 =C2=B1  5%     -63.8%   34185071 =C2=B1 15%  cpuidle.C1E.usage
  2.62e+08 =C2=B1  8%     -90.1%   26020649        cpuidle.POLL.time
  81581001 =C2=B1  9%     -96.1%    3221876        cpuidle.POLL.usage
     84602 =C2=B1  3%     +12.7%      95329 =C2=B1  5%  softirqs.CPU65.SCHE=
D
     86631 =C2=B1  5%     +10.9%      96057 =C2=B1  6%  softirqs.CPU67.SCHE=
D
     81448 =C2=B1  3%     +12.6%      91708        softirqs.CPU70.SCHED
     99715            +8.1%     107808 =C2=B1  2%  softirqs.CPU75.SCHED
     91997 =C2=B1  4%     +15.5%     106236 =C2=B1  2%  softirqs.CPU81.SCHE=
D
    417904 =C2=B1  6%     +43.6%     600289 =C2=B1 16%  sched_debug.cfs_rq:=
/.MIN_vruntime.avg
   3142033            +9.7%    3446986 =C2=B1  4%  sched_debug.cfs_rq:/.MIN=
_vruntime.max
    969106           +20.4%    1166681 =C2=B1  8%  sched_debug.cfs_rq:/.MIN=
_vruntime.stddev
     44659 =C2=B1 12%     +21.1%      54091 =C2=B1  3%  sched_debug.cfs_rq:=
/.exec_clock.min
     12198 =C2=B1 12%     +24.5%      15181 =C2=B1  9%  sched_debug.cfs_rq:=
/.load.avg
    417904 =C2=B1  6%     +43.6%     600289 =C2=B1 16%  sched_debug.cfs_rq:=
/.max_vruntime.avg
   3142033            +9.7%    3446986 =C2=B1  4%  sched_debug.cfs_rq:/.max=
_vruntime.max
    969106           +20.4%    1166681 =C2=B1  8%  sched_debug.cfs_rq:/.max=
_vruntime.stddev
   1926443 =C2=B1 12%     +25.6%    2419565 =C2=B1  3%  sched_debug.cfs_rq:=
/.min_vruntime.min
      0.41 =C2=B1  2%     +16.3%       0.47 =C2=B1  3%  sched_debug.cfs_rq:=
/.nr_running.avg
    322.15 =C2=B1  2%     +13.5%     365.49 =C2=B1  4%  sched_debug.cfs_rq:=
/.util_est_enqueued.avg
     58399 =C2=B1 49%     -62.5%      21882 =C2=B1 74%  sched_debug.cpu.avg=
_idle.min
      3.74 =C2=B1 14%     -20.1%       2.99 =C2=B1  3%  sched_debug.cpu.clo=
ck.stddev
     20770 =C2=B1 50%     -65.0%       7271 =C2=B1 39%  sched_debug.cpu.max=
_idle_balance_cost.stddev
   8250432           -16.5%    6887763        sched_debug.cpu.nr_switches.a=
vg
  11243220 =C2=B1  4%     -21.5%    8826971        sched_debug.cpu.nr_switc=
hes.max
   1603956 =C2=B1 26%     -52.5%     761566 =C2=B1  4%  sched_debug.cpu.nr_=
switches.stddev
   8248654           -16.5%    6885987        sched_debug.cpu.sched_count.a=
vg
  11240496 =C2=B1  4%     -21.5%    8823964        sched_debug.cpu.sched_co=
unt.max
   1603802 =C2=B1 26%     -52.5%     761522 =C2=B1  4%  sched_debug.cpu.sch=
ed_count.stddev
   4123397           -16.5%    3441927        sched_debug.cpu.sched_goidle.=
avg
   5619132 =C2=B1  4%     -21.5%    4410755        sched_debug.cpu.sched_go=
idle.max
    801761 =C2=B1 26%     -52.5%     380727 =C2=B1  4%  sched_debug.cpu.sch=
ed_goidle.stddev
   4124921           -16.5%    3443709        sched_debug.cpu.ttwu_count.av=
g
   5620396 =C2=B1  4%     -21.5%    4412427        sched_debug.cpu.ttwu_cou=
nt.max
    801796 =C2=B1 26%     -52.5%     380615 =C2=B1  4%  sched_debug.cpu.ttw=
u_count.stddev
  7.45e+09           -14.3%  6.382e+09        perf-stat.i.branch-instructio=
ns
      1.33            -0.1        1.24        perf-stat.i.branch-miss-rate%
  91615750           -22.0%   71469356        perf-stat.i.branch-misses
      3.80            +2.5        6.31 =C2=B1 13%  perf-stat.i.cache-miss-r=
ate%
   8753636 =C2=B1  4%    +109.7%   18358392        perf-stat.i.cache-misses
 7.691e+08           -14.2%  6.597e+08        perf-stat.i.cache-references
   4428060           -16.4%    3704052        perf-stat.i.context-switches
      2.87           +11.2%       3.20        perf-stat.i.cpi
 8.789e+10            -5.6%  8.294e+10        perf-stat.i.cpu-cycles
     16303 =C2=B1  7%     -74.2%       4204 =C2=B1  2%  perf-stat.i.cycles-=
between-cache-misses
  8.94e+09           -14.0%  7.685e+09        perf-stat.i.dTLB-loads
 4.951e+09           -16.2%  4.149e+09        perf-stat.i.dTLB-stores
  57458394           -17.3%   47543962        perf-stat.i.iTLB-load-misses
  30827890           -15.9%   25930501        perf-stat.i.iTLB-loads
 3.327e+10           -14.6%  2.842e+10        perf-stat.i.instructions
    581.15            +3.3%     600.28        perf-stat.i.instructions-per-=
iTLB-miss
      0.36            -9.4%       0.33        perf-stat.i.ipc
      0.92            -5.6%       0.86        perf-stat.i.metric.GHz
      1.01 =C2=B1  4%     +17.6%       1.18 =C2=B1  4%  perf-stat.i.metric.=
K/sec
    230.75           -14.6%     197.02        perf-stat.i.metric.M/sec
     87.41            +8.0       95.42        perf-stat.i.node-load-miss-ra=
te%
   1718045 =C2=B1  3%    +125.3%    3871440        perf-stat.i.node-load-mi=
sses
    227252 =C2=B1  3%     -71.5%      64814 =C2=B1 10%  perf-stat.i.node-lo=
ads
   1686277 =C2=B1  4%    +120.6%    3720452        perf-stat.i.node-store-m=
isses
      1.23            -0.1        1.12        perf-stat.overall.branch-miss=
-rate%
      1.14 =C2=B1  5%      +1.6        2.78        perf-stat.overall.cache-=
miss-rate%
      2.64           +10.5%       2.92        perf-stat.overall.cpi
     10070 =C2=B1  4%     -55.1%       4519        perf-stat.overall.cycles=
-between-cache-misses
    579.14            +3.2%     597.84        perf-stat.overall.instruction=
s-per-iTLB-miss
      0.38            -9.5%       0.34        perf-stat.overall.ipc
     88.31           +10.0       98.35        perf-stat.overall.node-load-m=
iss-rate%
     97.96            +1.3       99.24        perf-stat.overall.node-store-=
miss-rate%
     22430            +3.3%      23175        perf-stat.overall.path-length
 7.434e+09           -14.4%  6.365e+09        perf-stat.ps.branch-instructi=
ons
  91428244           -22.0%   71275228        perf-stat.ps.branch-misses
   8723893 =C2=B1  4%    +109.8%   18304568        perf-stat.ps.cache-misse=
s
 7.674e+08           -14.3%  6.578e+08        perf-stat.ps.cache-references
   4418679           -16.4%    3693530        perf-stat.ps.context-switches
  8.77e+10            -5.7%  8.271e+10        perf-stat.ps.cpu-cycles
 8.921e+09           -14.1%  7.664e+09        perf-stat.ps.dTLB-loads
  4.94e+09           -16.3%  4.137e+09        perf-stat.ps.dTLB-stores
  57330404           -17.3%   47408036        perf-stat.ps.iTLB-load-misses
  30765981           -15.9%   25859786        perf-stat.ps.iTLB-loads
  3.32e+10           -14.6%  2.834e+10        perf-stat.ps.instructions
   1712299 =C2=B1  3%    +125.4%    3860240        perf-stat.ps.node-load-m=
isses
    226568 =C2=B1  3%     -71.4%      64722 =C2=B1 10%  perf-stat.ps.node-l=
oads
   1680387 =C2=B1  4%    +120.8%    3709583        perf-stat.ps.node-store-=
misses
 1.302e+13           -14.7%  1.111e+13        perf-stat.total.instructions
   3591158 =C2=B1  5%     -25.1%    2688593        interrupts.CAL:Function_=
call_interrupts
      2328 =C2=B1 19%     +42.8%       3323 =C2=B1  3%  interrupts.CPU0.NMI=
:Non-maskable_interrupts
      2328 =C2=B1 19%     +42.8%       3323 =C2=B1  3%  interrupts.CPU0.PMI=
:Performance_monitoring_interrupts
    110354 =C2=B1  9%     -20.0%      88244 =C2=B1  4%  interrupts.CPU0.RES=
:Rescheduling_interrupts
    128508 =C2=B1 14%     -27.1%      93721 =C2=B1  3%  interrupts.CPU1.RES=
:Rescheduling_interrupts
      2180 =C2=B1 30%     +47.0%       3205 =C2=B1 15%  interrupts.CPU10.NM=
I:Non-maskable_interrupts
      2180 =C2=B1 30%     +47.0%       3205 =C2=B1 15%  interrupts.CPU10.PM=
I:Performance_monitoring_interrupts
    133107 =C2=B1  8%     -25.7%      98924 =C2=B1  2%  interrupts.CPU10.RE=
S:Rescheduling_interrupts
    133955 =C2=B1 13%     -28.9%      95305 =C2=B1  6%  interrupts.CPU11.RE=
S:Rescheduling_interrupts
    129709 =C2=B1 10%     -24.9%      97452 =C2=B1  8%  interrupts.CPU12.RE=
S:Rescheduling_interrupts
    130073 =C2=B1 10%     -21.2%     102507 =C2=B1  2%  interrupts.CPU13.RE=
S:Rescheduling_interrupts
    136313 =C2=B1 10%     -27.4%      99010 =C2=B1  3%  interrupts.CPU14.RE=
S:Rescheduling_interrupts
    139937 =C2=B1  7%     -29.9%      98077 =C2=B1  7%  interrupts.CPU15.RE=
S:Rescheduling_interrupts
    143424 =C2=B1 11%     -28.4%     102678 =C2=B1  7%  interrupts.CPU16.RE=
S:Rescheduling_interrupts
    138084 =C2=B1 10%     -25.7%     102625 =C2=B1  5%  interrupts.CPU17.RE=
S:Rescheduling_interrupts
    136238 =C2=B1  6%     -26.3%     100366 =C2=B1  7%  interrupts.CPU18.RE=
S:Rescheduling_interrupts
    140011 =C2=B1 10%     -28.4%     100232 =C2=B1  4%  interrupts.CPU19.RE=
S:Rescheduling_interrupts
    129720 =C2=B1  7%     -28.8%      92405 =C2=B1  7%  interrupts.CPU2.RES=
:Rescheduling_interrupts
     43177 =C2=B1 33%     -34.6%      28234 =C2=B1  5%  interrupts.CPU20.CA=
L:Function_call_interrupts
    143060 =C2=B1  6%     -28.5%     102289 =C2=B1  7%  interrupts.CPU20.RE=
S:Rescheduling_interrupts
     39911 =C2=B1 20%     -30.4%      27788 =C2=B1  4%  interrupts.CPU21.CA=
L:Function_call_interrupts
    144644 =C2=B1  9%     -27.6%     104676 =C2=B1  6%  interrupts.CPU21.RE=
S:Rescheduling_interrupts
     38543 =C2=B1 21%     -35.1%      25019 =C2=B1 14%  interrupts.CPU22.CA=
L:Function_call_interrupts
    144984 =C2=B1  7%     -29.9%     101700 =C2=B1  2%  interrupts.CPU22.RE=
S:Rescheduling_interrupts
     37835 =C2=B1 15%     -22.9%      29155 =C2=B1  5%  interrupts.CPU23.CA=
L:Function_call_interrupts
      2089 =C2=B1 19%     +70.6%       3565 =C2=B1 20%  interrupts.CPU23.NM=
I:Non-maskable_interrupts
      2089 =C2=B1 19%     +70.6%       3565 =C2=B1 20%  interrupts.CPU23.PM=
I:Performance_monitoring_interrupts
    130192 =C2=B1  7%     -22.1%     101416 =C2=B1  5%  interrupts.CPU23.RE=
S:Rescheduling_interrupts
     37142 =C2=B1  6%     -32.8%      24974 =C2=B1  6%  interrupts.CPU24.CA=
L:Function_call_interrupts
    142384 =C2=B1  5%     -31.7%      97277 =C2=B1  6%  interrupts.CPU24.RE=
S:Rescheduling_interrupts
     32664 =C2=B1  9%     -22.2%      25422 =C2=B1  6%  interrupts.CPU25.CA=
L:Function_call_interrupts
    141175 =C2=B1  5%     -31.2%      97084 =C2=B1  2%  interrupts.CPU25.RE=
S:Rescheduling_interrupts
     31023 =C2=B1 21%     -24.8%      23330 =C2=B1  7%  interrupts.CPU26.CA=
L:Function_call_interrupts
    131921 =C2=B1  4%     -28.9%      93831 =C2=B1  3%  interrupts.CPU26.RE=
S:Rescheduling_interrupts
     32946 =C2=B1 19%     -26.2%      24303 =C2=B1  5%  interrupts.CPU27.CA=
L:Function_call_interrupts
    144853 =C2=B1  4%     -35.7%      93190 =C2=B1  2%  interrupts.CPU27.RE=
S:Rescheduling_interrupts
    136419 =C2=B1  4%     -31.3%      93690        interrupts.CPU28.RES:Res=
cheduling_interrupts
     36609 =C2=B1 20%     -35.3%      23696 =C2=B1  5%  interrupts.CPU29.CA=
L:Function_call_interrupts
    145284 =C2=B1 10%     -36.1%      92871        interrupts.CPU29.RES:Res=
cheduling_interrupts
    122699 =C2=B1  7%     -23.8%      93459 =C2=B1 10%  interrupts.CPU3.RES=
:Rescheduling_interrupts
    250.50 =C2=B1 40%     -79.9%      50.25 =C2=B1 99%  interrupts.CPU3.TLB=
:TLB_shootdowns
     35689 =C2=B1 19%     -36.1%      22793 =C2=B1 11%  interrupts.CPU30.CA=
L:Function_call_interrupts
    152345 =C2=B1  4%     -40.3%      90991 =C2=B1  3%  interrupts.CPU30.RE=
S:Rescheduling_interrupts
     33895 =C2=B1 10%     -15.1%      28774 =C2=B1  8%  interrupts.CPU31.CA=
L:Function_call_interrupts
    150590 =C2=B1  5%     -35.5%      97092 =C2=B1  7%  interrupts.CPU31.RE=
S:Rescheduling_interrupts
     50156 =C2=B1 28%     -45.8%      27170 =C2=B1  7%  interrupts.CPU32.CA=
L:Function_call_interrupts
      3757 =C2=B1  7%     -43.6%       2120 =C2=B1 32%  interrupts.CPU32.NM=
I:Non-maskable_interrupts
      3757 =C2=B1  7%     -43.6%       2120 =C2=B1 32%  interrupts.CPU32.PM=
I:Performance_monitoring_interrupts
    150142 =C2=B1  3%     -36.3%      95673        interrupts.CPU32.RES:Res=
cheduling_interrupts
     39957 =C2=B1 25%     -34.5%      26158 =C2=B1  4%  interrupts.CPU33.CA=
L:Function_call_interrupts
    147066 =C2=B1  8%     -34.4%      96521 =C2=B1  2%  interrupts.CPU33.RE=
S:Rescheduling_interrupts
    168.25 =C2=B1137%     -86.9%      22.00 =C2=B1 59%  interrupts.CPU33.TL=
B:TLB_shootdowns
     38357 =C2=B1 13%     -29.9%      26881 =C2=B1  5%  interrupts.CPU34.CA=
L:Function_call_interrupts
      3757 =C2=B1  5%     -28.5%       2686 =C2=B1 19%  interrupts.CPU34.NM=
I:Non-maskable_interrupts
      3757 =C2=B1  5%     -28.5%       2686 =C2=B1 19%  interrupts.CPU34.PM=
I:Performance_monitoring_interrupts
    140734 =C2=B1  2%     -33.3%      93841 =C2=B1  3%  interrupts.CPU34.RE=
S:Rescheduling_interrupts
     37965 =C2=B1 17%     -25.8%      28175 =C2=B1  4%  interrupts.CPU35.CA=
L:Function_call_interrupts
      3934 =C2=B1  8%     -39.3%       2389 =C2=B1 13%  interrupts.CPU35.NM=
I:Non-maskable_interrupts
      3934 =C2=B1  8%     -39.3%       2389 =C2=B1 13%  interrupts.CPU35.PM=
I:Performance_monitoring_interrupts
    146074 =C2=B1 10%     -33.2%      97630 =C2=B1  2%  interrupts.CPU35.RE=
S:Rescheduling_interrupts
     34131 =C2=B1  8%     -18.8%      27704 =C2=B1  9%  interrupts.CPU36.CA=
L:Function_call_interrupts
    149093 =C2=B1  3%     -35.0%      96945 =C2=B1  4%  interrupts.CPU36.RE=
S:Rescheduling_interrupts
     44333 =C2=B1 47%     -39.7%      26745 =C2=B1  7%  interrupts.CPU37.CA=
L:Function_call_interrupts
    149936 =C2=B1  4%     -34.3%      98542 =C2=B1  3%  interrupts.CPU37.RE=
S:Rescheduling_interrupts
     41199 =C2=B1 28%     -30.2%      28741 =C2=B1  6%  interrupts.CPU38.CA=
L:Function_call_interrupts
    154224 =C2=B1  3%     -31.6%     105443 =C2=B1  7%  interrupts.CPU38.RE=
S:Rescheduling_interrupts
     36925 =C2=B1  8%     -24.3%      27942 =C2=B1  5%  interrupts.CPU39.CA=
L:Function_call_interrupts
    150490 =C2=B1  2%     -32.5%     101625 =C2=B1  4%  interrupts.CPU39.RE=
S:Rescheduling_interrupts
    122742 =C2=B1 15%     -25.4%      91596 =C2=B1  5%  interrupts.CPU4.RES=
:Rescheduling_interrupts
    143639 =C2=B1  9%     -29.4%     101407 =C2=B1  2%  interrupts.CPU40.RE=
S:Rescheduling_interrupts
     43235 =C2=B1 10%     -30.9%      29877 =C2=B1  4%  interrupts.CPU41.CA=
L:Function_call_interrupts
    158981 =C2=B1  5%     -32.8%     106760 =C2=B1  4%  interrupts.CPU41.RE=
S:Rescheduling_interrupts
     47792 =C2=B1 33%     -37.7%      29769 =C2=B1  5%  interrupts.CPU42.CA=
L:Function_call_interrupts
      3455 =C2=B1 11%     -32.2%       2343 =C2=B1 36%  interrupts.CPU42.NM=
I:Non-maskable_interrupts
      3455 =C2=B1 11%     -32.2%       2343 =C2=B1 36%  interrupts.CPU42.PM=
I:Performance_monitoring_interrupts
    160241 =C2=B1  5%     -34.0%     105793 =C2=B1  4%  interrupts.CPU42.RE=
S:Rescheduling_interrupts
     54419 =C2=B1 52%     -44.1%      30408 =C2=B1  2%  interrupts.CPU43.CA=
L:Function_call_interrupts
      3726 =C2=B1 11%     -38.7%       2285 =C2=B1 39%  interrupts.CPU43.NM=
I:Non-maskable_interrupts
      3726 =C2=B1 11%     -38.7%       2285 =C2=B1 39%  interrupts.CPU43.PM=
I:Performance_monitoring_interrupts
    156010           -32.4%     105516 =C2=B1  2%  interrupts.CPU43.RES:Res=
cheduling_interrupts
     69033 =C2=B1 79%     -56.0%      30393 =C2=B1  7%  interrupts.CPU44.CA=
L:Function_call_interrupts
    152478 =C2=B1  6%     -30.4%     106187 =C2=B1  4%  interrupts.CPU44.RE=
S:Rescheduling_interrupts
     49434 =C2=B1 49%     -38.5%      30404 =C2=B1  9%  interrupts.CPU45.CA=
L:Function_call_interrupts
    153770 =C2=B1  7%     -32.2%     104200 =C2=B1  3%  interrupts.CPU45.RE=
S:Rescheduling_interrupts
     56303 =C2=B1 52%     -50.4%      27914 =C2=B1  4%  interrupts.CPU46.CA=
L:Function_call_interrupts
      3924 =C2=B1 20%     -48.7%       2012 =C2=B1 50%  interrupts.CPU46.NM=
I:Non-maskable_interrupts
      3924 =C2=B1 20%     -48.7%       2012 =C2=B1 50%  interrupts.CPU46.PM=
I:Performance_monitoring_interrupts
    152891 =C2=B1 11%     -31.7%     104494 =C2=B1  5%  interrupts.CPU46.RE=
S:Rescheduling_interrupts
     42970 =C2=B1 30%     -29.9%      30107 =C2=B1  9%  interrupts.CPU47.CA=
L:Function_call_interrupts
      3940 =C2=B1  8%     -40.8%       2332 =C2=B1 38%  interrupts.CPU47.NM=
I:Non-maskable_interrupts
      3940 =C2=B1  8%     -40.8%       2332 =C2=B1 38%  interrupts.CPU47.PM=
I:Performance_monitoring_interrupts
    146615 =C2=B1  5%     -27.7%     106013 =C2=B1  4%  interrupts.CPU47.RE=
S:Rescheduling_interrupts
    146863 =C2=B1  5%     -18.4%     119774 =C2=B1  3%  interrupts.CPU48.RE=
S:Rescheduling_interrupts
    136692 =C2=B1  8%     -16.3%     114405 =C2=B1  7%  interrupts.CPU49.RE=
S:Rescheduling_interrupts
     29311 =C2=B1  6%     -12.4%      25673 =C2=B1  4%  interrupts.CPU5.CAL=
:Function_call_interrupts
    129497 =C2=B1  7%     -27.1%      94375 =C2=B1  6%  interrupts.CPU5.RES=
:Rescheduling_interrupts
    143797 =C2=B1 11%     -21.0%     113564 =C2=B1  4%  interrupts.CPU50.RE=
S:Rescheduling_interrupts
      2891 =C2=B1 16%     +31.3%       3797 =C2=B1 12%  interrupts.CPU51.NM=
I:Non-maskable_interrupts
      2891 =C2=B1 16%     +31.3%       3797 =C2=B1 12%  interrupts.CPU51.PM=
I:Performance_monitoring_interrupts
    139766 =C2=B1  2%     -19.6%     112352 =C2=B1  8%  interrupts.CPU51.RE=
S:Rescheduling_interrupts
    137319 =C2=B1  4%     -20.3%     109422 =C2=B1  5%  interrupts.CPU52.RE=
S:Rescheduling_interrupts
    138705 =C2=B1  5%     -21.3%     109158 =C2=B1  8%  interrupts.CPU53.RE=
S:Rescheduling_interrupts
      2426 =C2=B1 28%     +42.8%       3464 =C2=B1 19%  interrupts.CPU54.NM=
I:Non-maskable_interrupts
      2426 =C2=B1 28%     +42.8%       3464 =C2=B1 19%  interrupts.CPU54.PM=
I:Performance_monitoring_interrupts
    140683 =C2=B1 11%     -24.0%     106919 =C2=B1  4%  interrupts.CPU54.RE=
S:Rescheduling_interrupts
     38238 =C2=B1 13%     -22.9%      29493 =C2=B1  6%  interrupts.CPU55.CA=
L:Function_call_interrupts
      3043 =C2=B1  8%     +18.7%       3612 =C2=B1  7%  interrupts.CPU55.NM=
I:Non-maskable_interrupts
      3043 =C2=B1  8%     +18.7%       3612 =C2=B1  7%  interrupts.CPU55.PM=
I:Performance_monitoring_interrupts
    143657 =C2=B1 10%     -25.0%     107806 =C2=B1  6%  interrupts.CPU55.RE=
S:Rescheduling_interrupts
    131036 =C2=B1  8%     -21.3%     103177 =C2=B1  4%  interrupts.CPU56.RE=
S:Rescheduling_interrupts
    131204 =C2=B1 12%     -21.2%     103444 =C2=B1 10%  interrupts.CPU57.RE=
S:Rescheduling_interrupts
    122041 =C2=B1 12%     -15.9%     102674 =C2=B1  7%  interrupts.CPU58.RE=
S:Rescheduling_interrupts
    167.25 =C2=B1 65%     -64.7%      59.00 =C2=B1157%  interrupts.CPU58.TL=
B:TLB_shootdowns
      1883 =C2=B1 33%     +61.6%       3042 =C2=B1  3%  interrupts.CPU6.NMI=
:Non-maskable_interrupts
      1883 =C2=B1 33%     +61.6%       3042 =C2=B1  3%  interrupts.CPU6.PMI=
:Performance_monitoring_interrupts
    132101 =C2=B1 12%     -27.0%      96457 =C2=B1  8%  interrupts.CPU6.RES=
:Rescheduling_interrupts
      1832 =C2=B1 24%     +69.3%       3102 =C2=B1 32%  interrupts.CPU64.NM=
I:Non-maskable_interrupts
      1832 =C2=B1 24%     +69.3%       3102 =C2=B1 32%  interrupts.CPU64.PM=
I:Performance_monitoring_interrupts
    107979 =C2=B1  8%     -11.6%      95452        interrupts.CPU66.RES:Res=
cheduling_interrupts
     97965 =C2=B1  3%     -15.1%      83199 =C2=B1  2%  interrupts.CPU69.RE=
S:Rescheduling_interrupts
    126380 =C2=B1 11%     -24.6%      95257 =C2=B1  5%  interrupts.CPU7.RES=
:Rescheduling_interrupts
      1820 =C2=B1 40%     +60.9%       2929 =C2=B1 35%  interrupts.CPU70.NM=
I:Non-maskable_interrupts
      1820 =C2=B1 40%     +60.9%       2929 =C2=B1 35%  interrupts.CPU70.PM=
I:Performance_monitoring_interrupts
    171279 =C2=B1  5%     -29.4%     120994 =C2=B1  5%  interrupts.CPU72.RE=
S:Rescheduling_interrupts
     50761 =C2=B1 40%     -35.0%      32979 =C2=B1  7%  interrupts.CPU73.CA=
L:Function_call_interrupts
    173132 =C2=B1  7%     -31.5%     118555 =C2=B1  5%  interrupts.CPU73.RE=
S:Rescheduling_interrupts
     43479 =C2=B1 17%     -25.8%      32276 =C2=B1  3%  interrupts.CPU74.CA=
L:Function_call_interrupts
      3755 =C2=B1  9%     -31.7%       2564 =C2=B1 31%  interrupts.CPU74.NM=
I:Non-maskable_interrupts
      3755 =C2=B1  9%     -31.7%       2564 =C2=B1 31%  interrupts.CPU74.PM=
I:Performance_monitoring_interrupts
    167124 =C2=B1  7%     -28.8%     119063 =C2=B1  4%  interrupts.CPU74.RE=
S:Rescheduling_interrupts
    164069 =C2=B1  7%     -26.6%     120499 =C2=B1  4%  interrupts.CPU75.RE=
S:Rescheduling_interrupts
    166858 =C2=B1  6%     -28.4%     119453 =C2=B1  4%  interrupts.CPU76.RE=
S:Rescheduling_interrupts
    157535 =C2=B1  6%     -25.5%     117419 =C2=B1  4%  interrupts.CPU77.RE=
S:Rescheduling_interrupts
    165642 =C2=B1  8%     -25.9%     122719 =C2=B1  8%  interrupts.CPU78.RE=
S:Rescheduling_interrupts
    162781 =C2=B1  5%     -29.0%     115600 =C2=B1  3%  interrupts.CPU79.RE=
S:Rescheduling_interrupts
    132224 =C2=B1 11%     -26.6%      97010        interrupts.CPU8.RES:Resc=
heduling_interrupts
    167082 =C2=B1  9%     -30.7%     115794 =C2=B1  4%  interrupts.CPU80.RE=
S:Rescheduling_interrupts
     49639 =C2=B1 37%     -35.1%      32228 =C2=B1  2%  interrupts.CPU81.CA=
L:Function_call_interrupts
    144305 =C2=B1  5%     -18.3%     117926 =C2=B1  4%  interrupts.CPU81.RE=
S:Rescheduling_interrupts
    151333 =C2=B1  7%     -23.2%     116159 =C2=B1  3%  interrupts.CPU82.RE=
S:Rescheduling_interrupts
    142398 =C2=B1  8%     -21.1%     112399 =C2=B1  7%  interrupts.CPU83.RE=
S:Rescheduling_interrupts
    144455 =C2=B1  2%     -20.5%     114911        interrupts.CPU84.RES:Res=
cheduling_interrupts
    149850 =C2=B1  9%     -24.3%     113396 =C2=B1  5%  interrupts.CPU85.RE=
S:Rescheduling_interrupts
     34458 =C2=B1  4%     -14.4%      29487 =C2=B1  8%  interrupts.CPU86.CA=
L:Function_call_interrupts
    138603 =C2=B1  6%     -22.7%     107133 =C2=B1  2%  interrupts.CPU86.RE=
S:Rescheduling_interrupts
     39228 =C2=B1  7%     -25.5%      29231 =C2=B1  4%  interrupts.CPU87.CA=
L:Function_call_interrupts
    151814 =C2=B1  8%     -31.1%     104629 =C2=B1  5%  interrupts.CPU87.RE=
S:Rescheduling_interrupts
    137356 =C2=B1  8%     -20.2%     109634 =C2=B1  3%  interrupts.CPU88.RE=
S:Rescheduling_interrupts
    143613 =C2=B1 10%     -28.9%     102166 =C2=B1 10%  interrupts.CPU89.RE=
S:Rescheduling_interrupts
    122375 =C2=B1  8%     -19.2%      98901 =C2=B1  3%  interrupts.CPU9.RES=
:Rescheduling_interrupts
    140781 =C2=B1  6%     -25.0%     105531 =C2=B1  3%  interrupts.CPU90.RE=
S:Rescheduling_interrupts
    138917 =C2=B1 12%     -24.9%     104264 =C2=B1  5%  interrupts.CPU91.RE=
S:Rescheduling_interrupts
    146814 =C2=B1 14%     -29.2%     103902 =C2=B1  4%  interrupts.CPU92.RE=
S:Rescheduling_interrupts
    132220 =C2=B1 15%     -21.3%     104095 =C2=B1  2%  interrupts.CPU93.RE=
S:Rescheduling_interrupts
    133.00 =C2=B1 88%     -87.6%      16.50 =C2=B1 72%  interrupts.CPU93.TL=
B:TLB_shootdowns
    125991 =C2=B1  5%     -19.0%     101995 =C2=B1  2%  interrupts.CPU94.RE=
S:Rescheduling_interrupts
    115838 =C2=B1  9%     -17.2%      95959 =C2=B1  3%  interrupts.CPU95.RE=
S:Rescheduling_interrupts
  13255498 =C2=B1  2%     -25.6%    9859155        interrupts.RES:Reschedul=
ing_interrupts
      7.59 =C2=B1  2%      -1.5        6.04        perf-profile.calltrace.c=
ycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe
      7.43 =C2=B1  2%      -1.5        5.91        perf-profile.calltrace.c=
ycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      6.03 =C2=B1  4%      -1.0        5.06        perf-profile.calltrace.c=
ycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.90 =C2=B1  4%      -1.0        4.95        perf-profile.calltrace.c=
ycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.44 =C2=B1  3%      -0.9        3.51        perf-profile.calltrace.c=
ycles-pp.schedule.pipe_read.new_sync_read.vfs_read.ksys_read
      2.29 =C2=B1  4%      -0.9        1.38 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.new_sync_read
      4.07 =C2=B1  3%      -0.9        3.21        perf-profile.calltrace.c=
ycles-pp.__schedule.schedule.pipe_read.new_sync_read.vfs_read
      2.62 =C2=B1  3%      -0.9        1.76 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.read
      3.68 =C2=B1  2%      -0.8        2.83        perf-profile.calltrace.c=
ycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_=
startup_64_no_verify
      2.06 =C2=B1  4%      -0.8        1.22        perf-profile.calltrace.c=
ycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      3.58 =C2=B1  2%      -0.8        2.76        perf-profile.calltrace.c=
ycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      2.37 =C2=B1  3%      -0.8        1.58 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      2.29 =C2=B1  3%      -0.8        1.53 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.26 =C2=B1  3%      -0.8        1.50 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.21 =C2=B1  3%      -0.7        1.47 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.read
      4.25 =C2=B1  3%      -0.7        3.51        perf-profile.calltrace.c=
ycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.en=
queue_task_fair.ttwu_do_activate
      2.14 =C2=B1  4%      -0.6        1.52        perf-profile.calltrace.c=
ycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_s=
cheduler_latency.enqueue_entity
      3.48 =C2=B1  4%      -0.6        2.90 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_late=
ncy.enqueue_entity.enqueue_task_fair
      1.93 =C2=B1  3%      -0.5        1.48        perf-profile.calltrace.c=
ycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_e=
ntry
      1.54 =C2=B1  4%      -0.4        1.18        perf-profile.calltrace.c=
ycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_st=
artup_64_no_verify
      1.38 =C2=B1  3%      -0.3        1.04 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.=
do_idle
      0.72 =C2=B1  4%      -0.1        0.58 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_en=
try.start_secondary
      0.66 =C2=B1  4%      -0.1        0.54 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.prepare_to_wait_event.pipe_read.new_sync_read.vfs_read.ksys_r=
ead
     46.28            +0.5       46.74        perf-profile.calltrace.cycles=
-pp.secondary_startup_64_no_verify
      0.14 =C2=B1173%      +0.5        0.66 =C2=B1  9%  perf-profile.calltr=
ace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondar=
y_startup_64_no_verify
      0.14 =C2=B1173%      +0.5        0.66 =C2=B1  9%  perf-profile.calltr=
ace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.s=
tart_kernel
      0.15 =C2=B1173%      +0.6        0.71 =C2=B1  8%  perf-profile.calltr=
ace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.15 =C2=B1173%      +0.6        0.71 =C2=B1  8%  perf-profile.calltr=
ace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_n=
o_verify
      0.15 =C2=B1173%      +0.6        0.71 =C2=B1  8%  perf-profile.calltr=
ace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      7.85 =C2=B1  2%      +0.8        8.64 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.write
      7.77 =C2=B1  2%      +0.8        8.58 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      7.73 =C2=B1  2%      +0.8        8.55 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.69 =C2=B1  3%      +0.8        8.53 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.64 =C2=B1  3%      +0.9        8.49 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.write
     35.29            +0.9       36.15        perf-profile.calltrace.cycles=
-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.15            +0.9       36.02        perf-profile.calltrace.cycles=
-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.35            +1.8       44.15        perf-profile.calltrace.cycles=
-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
     42.22            +1.8       44.06        perf-profile.calltrace.cycles=
-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     38.77            +1.9       40.67        perf-profile.calltrace.cycles=
-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_start=
up_64_no_verify
     38.65            +1.9       40.56        perf-profile.calltrace.cycles=
-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secon=
dary
     40.84            +2.1       42.96        perf-profile.calltrace.cycles=
-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
     40.50            +2.1       42.65        perf-profile.calltrace.cycles=
-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_wr=
ite
     40.15            +2.2       42.36        perf-profile.calltrace.cycles=
-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_wr=
ite.new_sync_write
     40.07            +2.2       42.29        perf-profile.calltrace.cycles=
-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_comm=
on_lock.pipe_write
     37.50            +2.7       40.20        perf-profile.calltrace.cycles=
-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_comm=
on.__wake_up_common_lock
     37.47            +2.7       40.18        perf-profile.calltrace.cycles=
-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_funct=
ion.__wake_up_common
     36.96            +2.9       39.84        perf-profile.calltrace.cycles=
-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autore=
move_wake_function
     36.62 =C2=B1  2%      +3.2       39.86        perf-profile.calltrace.c=
ycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_e=
ntry
     34.50            +3.3       37.80        perf-profile.calltrace.cycles=
-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_ac=
tivate.try_to_wake_up
     29.96 =C2=B1  2%      +4.1       34.04        perf-profile.calltrace.c=
ycles-pp._raw_spin_lock_irqsave.__account_scheduler_latency.enqueue_entity.=
enqueue_task_fair.ttwu_do_activate
     29.13 =C2=B1  2%      +4.1       33.22        perf-profile.calltrace.c=
ycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__account_s=
cheduler_latency.enqueue_entity.enqueue_task_fair
      8.30 =C2=B1  2%      -1.7        6.58        perf-profile.children.cy=
cles-pp.ksys_read
      8.12 =C2=B1  2%      -1.7        6.42        perf-profile.children.cy=
cles-pp.vfs_read
      7.75 =C2=B1  2%      -1.7        6.06        perf-profile.children.cy=
cles-pp.__schedule
      7.59 =C2=B1  2%      -1.5        6.05        perf-profile.children.cy=
cles-pp.new_sync_read
      7.45 =C2=B1  2%      -1.5        5.94        perf-profile.children.cy=
cles-pp.pipe_read
      4.44 =C2=B1  3%      -0.9        3.52        perf-profile.children.cy=
cles-pp.schedule
      2.65 =C2=B1  3%      -0.9        1.78 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.read
      3.70 =C2=B1  2%      -0.8        2.87        perf-profile.children.cy=
cles-pp.schedule_idle
      4.28 =C2=B1  3%      -0.7        3.54        perf-profile.children.cy=
cles-pp.stack_trace_save_tsk
      0.80 =C2=B1 35%      -0.7        0.13 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.poll_idle
      3.54 =C2=B1  3%      -0.6        2.94 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.arch_stack_walk
      2.02 =C2=B1  3%      -0.6        1.43 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.update_load_avg
      2.15 =C2=B1  3%      -0.5        1.67        perf-profile.children.cy=
cles-pp.pick_next_task_fair
      2.30 =C2=B1  4%      -0.5        1.82        perf-profile.children.cy=
cles-pp.dequeue_task_fair
      2.10 =C2=B1  4%      -0.5        1.63 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.dequeue_entity
      1.56 =C2=B1  4%      -0.4        1.20        perf-profile.children.cy=
cles-pp.menu_select
      1.39 =C2=B1  3%      -0.3        1.06 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.set_next_entity
      0.46 =C2=B1 13%      -0.3        0.15 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.sched_ttwu_pending
      0.92 =C2=B1  3%      -0.2        0.70 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.prepare_to_wait_event
      1.13            -0.2        0.92 =C2=B1  3%  perf-profile.children.cy=
cles-pp.asm_call_sysvec_on_stack
      0.33 =C2=B1  9%      -0.2        0.12 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.asm_sysvec_call_function_single
      0.32 =C2=B1 10%      -0.2        0.11 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.__sysvec_call_function_single
      0.61 =C2=B1  3%      -0.2        0.41 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.__update_load_avg_cfs_rq
      0.32 =C2=B1 10%      -0.2        0.11 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.sysvec_call_function_single
      0.47 =C2=B1  6%      -0.2        0.28        perf-profile.children.cy=
cles-pp.finish_task_switch
      0.56 =C2=B1  5%      -0.2        0.36 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.unwind_get_return_address
      0.50 =C2=B1  6%      -0.2        0.32 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.__kernel_text_address
      0.96 =C2=B1  5%      -0.2        0.78        perf-profile.children.cy=
cles-pp.update_curr
      0.44 =C2=B1  6%      -0.2        0.27 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.kernel_text_address
      2.17 =C2=B1  4%      -0.2        2.00        perf-profile.children.cy=
cles-pp.unwind_next_frame
      0.73 =C2=B1  3%      -0.2        0.56 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.select_task_rq_fair
      0.95            -0.2        0.79 =C2=B1  2%  perf-profile.children.cy=
cles-pp.update_rq_clock
      0.74 =C2=B1  4%      -0.1        0.59 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.tick_nohz_get_sleep_length
      0.53 =C2=B1  3%      -0.1        0.40 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.ktime_get
      0.41 =C2=B1  4%      -0.1        0.28 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.stack_trace_consume_entry_nosched
      0.71            -0.1        0.59 =C2=B1  3%  perf-profile.children.cy=
cles-pp.mutex_lock
      0.50 =C2=B1  2%      -0.1        0.38 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.tick_nohz_idle_exit
      0.44            -0.1        0.33        perf-profile.children.cycles-=
pp.__orc_find
      0.52 =C2=B1  2%      -0.1        0.41 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.copy_page_to_iter
      0.15 =C2=B1 19%      -0.1        0.05 =C2=B1  8%  perf-profile.childr=
en.cycles-pp.flush_smp_call_function_from_idle
      0.44 =C2=B1  4%      -0.1        0.34 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.security_file_permission
      0.53 =C2=B1  2%      -0.1        0.43        perf-profile.children.cy=
cles-pp.__switch_to
      0.48 =C2=B1  3%      -0.1        0.38 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.__switch_to_asm
      0.37 =C2=B1  3%      -0.1        0.27 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.__update_load_avg_se
      0.67 =C2=B1  2%      -0.1        0.57 =C2=B1  2%  perf-profile.childr=
en.cycles-pp._raw_spin_lock
      0.32 =C2=B1  4%      -0.1        0.22 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.copy_page_from_iter
      0.38 =C2=B1  4%      -0.1        0.29 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.select_idle_sibling
      0.45 =C2=B1  5%      -0.1        0.37 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.tick_nohz_next_event
      0.29 =C2=B1  4%      -0.1        0.21 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.tick_nohz_idle_enter
      0.64 =C2=B1  2%      -0.1        0.57 =C2=B1  3%  perf-profile.childr=
en.cycles-pp._raw_spin_unlock_irqrestore
      0.38 =C2=B1  3%      -0.1        0.31 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.copyout
      0.27 =C2=B1  6%      -0.1        0.19 =C2=B1  6%  perf-profile.childr=
en.cycles-pp.orc_find
      0.40 =C2=B1  2%      -0.1        0.33 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.copy_user_generic_unrolled
      0.35 =C2=B1  4%      -0.1        0.28        perf-profile.children.cy=
cles-pp.pick_next_entity
      0.38 =C2=B1  4%      -0.1        0.31        perf-profile.children.cy=
cles-pp.update_cfs_group
      0.22 =C2=B1  4%      -0.1        0.16 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.___perf_sw_event
      0.30 =C2=B1  5%      -0.1        0.23 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.__unwind_start
      0.32 =C2=B1  4%      -0.1        0.26        perf-profile.children.cy=
cles-pp.ttwu_do_wakeup
      0.20 =C2=B1  4%      -0.1        0.14 =C2=B1  9%  perf-profile.childr=
en.cycles-pp.__might_sleep
      0.28 =C2=B1  6%      -0.1        0.22 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.syscall_return_via_sysret
      0.27 =C2=B1  4%      -0.1        0.21 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.common_file_perm
      0.18 =C2=B1  3%      -0.1        0.12 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.in_sched_functions
      0.30 =C2=B1  4%      -0.1        0.24        perf-profile.children.cy=
cles-pp.check_preempt_curr
      0.22 =C2=B1  4%      -0.1        0.17 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.rcu_idle_exit
      0.34 =C2=B1  3%      -0.1        0.28 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.sched_clock_cpu
      0.30 =C2=B1  4%      -0.1        0.24 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.update_ts_time_stats
      0.31 =C2=B1  5%      -0.1        0.25 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.nr_iowait_cpu
      0.31 =C2=B1  3%      -0.1        0.26 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.sched_clock
      0.21 =C2=B1  5%      -0.1        0.16 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.cpus_share_cache
      0.17 =C2=B1 10%      -0.1        0.11 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.place_entity
      0.28 =C2=B1  3%      -0.1        0.23 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.syscall_exit_to_user_mode
      0.18 =C2=B1  4%      -0.1        0.13 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.resched_curr
      0.33 =C2=B1  2%      -0.0        0.28 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.switch_mm_irqs_off
      0.29 =C2=B1  3%      -0.0        0.24 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.mutex_unlock
      0.23 =C2=B1  3%      -0.0        0.18 =C2=B1  2%  perf-profile.childr=
en.cycles-pp._raw_spin_lock_irq
      0.26 =C2=B1  3%      -0.0        0.21        perf-profile.children.cy=
cles-pp.___might_sleep
      0.20 =C2=B1  6%      -0.0        0.15 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.__list_del_entry_valid
      0.29 =C2=B1  5%      -0.0        0.25 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.native_sched_clock
      0.24 =C2=B1  5%      -0.0        0.19 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.get_next_timer_interrupt
      0.12 =C2=B1  5%      -0.0        0.08 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.cpuidle_governor_latency_req
      0.23 =C2=B1  8%      -0.0        0.19 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.hrtimer_next_event_without
      0.21 =C2=B1  3%      -0.0        0.17 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.read_tsc
      0.14 =C2=B1  3%      -0.0        0.10 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.rcu_eqs_exit
      0.12 =C2=B1  4%      -0.0        0.09 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.__entry_text_start
      0.19 =C2=B1  2%      -0.0        0.15 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.__fdget_pos
      0.08 =C2=B1  6%      -0.0        0.04 =C2=B1 58%  perf-profile.childr=
en.cycles-pp.rcu_dynticks_eqs_exit
      0.07 =C2=B1 10%      -0.0        0.04 =C2=B1 57%  perf-profile.childr=
en.cycles-pp.put_prev_entity
      0.11 =C2=B1 13%      -0.0        0.08 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.put_prev_task_fair
      0.17 =C2=B1  4%      -0.0        0.14 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.exit_to_user_mode_prepare
      0.15 =C2=B1  7%      -0.0        0.12 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.hrtimer_get_next_event
      0.16 =C2=B1  2%      -0.0        0.14 =C2=B1  6%  perf-profile.childr=
en.cycles-pp.__fget_light
      0.13 =C2=B1 10%      -0.0        0.10 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.is_bpf_text_address
      0.11 =C2=B1  6%      -0.0        0.08 =C2=B1  5%  perf-profile.childr=
en.cycles-pp.file_update_time
      0.14 =C2=B1  6%      -0.0        0.11 =C2=B1 11%  perf-profile.childr=
en.cycles-pp.__wrgsbase_inactive
      0.14 =C2=B1  8%      -0.0        0.11 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.available_idle_cpu
      0.09 =C2=B1  4%      -0.0        0.06 =C2=B1 13%  perf-profile.childr=
en.cycles-pp.menu_reflect
      0.13 =C2=B1  9%      -0.0        0.11 =C2=B1  6%  perf-profile.childr=
en.cycles-pp.stack_access_ok
      0.14 =C2=B1  5%      -0.0        0.12 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.switch_fpu_return
      0.10 =C2=B1  8%      -0.0        0.08 =C2=B1  6%  perf-profile.childr=
en.cycles-pp.current_time
      0.09 =C2=B1  9%      -0.0        0.07 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.__rdgsbase_inactive
      0.10            -0.0        0.08        perf-profile.children.cycles-=
pp.__calc_delta
      0.09 =C2=B1 10%      -0.0        0.07 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.bpf_ksym_find
      0.07 =C2=B1 10%      -0.0        0.05        perf-profile.children.cy=
cles-pp.pick_next_task_idle
      0.18 =C2=B1  3%      -0.0        0.16 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.fsnotify
      0.17 =C2=B1  5%      -0.0        0.15 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.copy_fpregs_to_fpstate
      0.07 =C2=B1  6%      -0.0        0.05        perf-profile.children.cy=
cles-pp.put_task_stack
      0.07 =C2=B1  6%      -0.0        0.05        perf-profile.children.cy=
cles-pp.apparmor_file_permission
      0.07 =C2=B1 12%      -0.0        0.05 =C2=B1  8%  perf-profile.childr=
en.cycles-pp.copy_user_enhanced_fast_string
      0.07 =C2=B1  6%      -0.0        0.05 =C2=B1  8%  perf-profile.childr=
en.cycles-pp.update_min_vruntime
      0.17 =C2=B1  2%      -0.0        0.16        perf-profile.children.cy=
cles-pp.anon_pipe_buf_release
      0.07 =C2=B1  5%      -0.0        0.06        perf-profile.children.cy=
cles-pp.atime_needs_update
      0.08 =C2=B1  5%      -0.0        0.07        perf-profile.children.cy=
cles-pp.finish_wait
      0.48 =C2=B1 14%      +0.2        0.71 =C2=B1  8%  perf-profile.childr=
en.cycles-pp.start_kernel
     46.28            +0.5       46.74        perf-profile.children.cycles-=
pp.secondary_startup_64_no_verify
     46.28            +0.5       46.74        perf-profile.children.cycles-=
pp.cpu_startup_entry
     46.25            +0.5       46.71        perf-profile.children.cycles-=
pp.do_idle
      7.88 =C2=B1  2%      +0.8        8.65 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.write
     42.99            +1.7       44.69        perf-profile.children.cycles-=
pp.ksys_write
     42.80            +1.7       44.53        perf-profile.children.cycles-=
pp.vfs_write
     42.37            +1.8       44.16        perf-profile.children.cycles-=
pp.new_sync_write
     42.23            +1.8       44.06        perf-profile.children.cycles-=
pp.pipe_write
     39.21            +2.1       41.33        perf-profile.children.cycles-=
pp.cpuidle_enter
     40.84            +2.1       42.96        perf-profile.children.cycles-=
pp.__wake_up_common_lock
     39.20            +2.1       41.32        perf-profile.children.cycles-=
pp.cpuidle_enter_state
     40.50            +2.2       42.65        perf-profile.children.cycles-=
pp.__wake_up_common
     40.15            +2.2       42.36        perf-profile.children.cycles-=
pp.autoremove_wake_function
     40.09            +2.2       42.30        perf-profile.children.cycles-=
pp.try_to_wake_up
     37.97            +2.4       40.36        perf-profile.children.cycles-=
pp.ttwu_do_activate
     37.94            +2.4       40.33        perf-profile.children.cycles-=
pp.enqueue_task_fair
     37.50            +2.5       40.05        perf-profile.children.cycles-=
pp.enqueue_entity
     36.91            +2.9       39.86        perf-profile.children.cycles-=
pp.intel_idle
     34.95            +3.0       37.95        perf-profile.children.cycles-=
pp.__account_scheduler_latency
     31.46            +3.5       35.00        perf-profile.children.cycles-=
pp._raw_spin_lock_irqsave
     29.71 =C2=B1  2%      +3.8       33.52        perf-profile.children.cy=
cles-pp.__cna_queued_spin_lock_slowpath
      0.71 =C2=B1 39%      -0.7        0.05 =C2=B1  8%  perf-profile.self.c=
ycles-pp.poll_idle
      1.08 =C2=B1  3%      -0.3        0.78        perf-profile.self.cycles=
-pp.update_load_avg
      1.24 =C2=B1  2%      -0.2        1.02 =C2=B1  2%  perf-profile.self.c=
ycles-pp.__schedule
      1.86            -0.2        1.65        perf-profile.self.cycles-pp._=
raw_spin_lock_irqsave
      0.59 =C2=B1  3%      -0.2        0.40 =C2=B1  4%  perf-profile.self.c=
ycles-pp.__update_load_avg_cfs_rq
      0.95 =C2=B1  3%      -0.2        0.75 =C2=B1  2%  perf-profile.self.c=
ycles-pp.set_next_entity
      0.66 =C2=B1  4%      -0.2        0.51 =C2=B1  6%  perf-profile.self.c=
ycles-pp.menu_select
      0.43 =C2=B1  5%      -0.1        0.28 =C2=B1  3%  perf-profile.self.c=
ycles-pp.enqueue_task_fair
      0.53 =C2=B1  3%      -0.1        0.40 =C2=B1  2%  perf-profile.self.c=
ycles-pp._raw_spin_lock
      0.67 =C2=B1  2%      -0.1        0.54 =C2=B1  2%  perf-profile.self.c=
ycles-pp.stack_trace_save_tsk
      0.77 =C2=B1  2%      -0.1        0.64 =C2=B1  2%  perf-profile.self.c=
ycles-pp.update_rq_clock
      0.72 =C2=B1  8%      -0.1        0.60        perf-profile.self.cycles=
-pp.update_curr
      0.44            -0.1        0.33        perf-profile.self.cycles-pp._=
_orc_find
      0.56 =C2=B1  2%      -0.1        0.45 =C2=B1  3%  perf-profile.self.c=
ycles-pp.pipe_read
      0.33 =C2=B1  4%      -0.1        0.22        perf-profile.self.cycles=
-pp.prepare_to_wait_event
      0.48 =C2=B1  3%      -0.1        0.38 =C2=B1  3%  perf-profile.self.c=
ycles-pp.__switch_to_asm
      0.32 =C2=B1  2%      -0.1        0.22 =C2=B1  7%  perf-profile.self.c=
ycles-pp.ktime_get
      0.47            -0.1        0.38 =C2=B1  2%  perf-profile.self.cycles=
-pp.__switch_to
      0.35 =C2=B1  2%      -0.1        0.26 =C2=B1  5%  perf-profile.self.c=
ycles-pp.select_task_rq_fair
      0.28 =C2=B1  5%      -0.1        0.20 =C2=B1  3%  perf-profile.self.c=
ycles-pp.dequeue_entity
      0.23 =C2=B1  6%      -0.1        0.15 =C2=B1  3%  perf-profile.self.c=
ycles-pp.stack_trace_consume_entry_nosched
      0.46 =C2=B1  3%      -0.1        0.39 =C2=B1  5%  perf-profile.self.c=
ycles-pp.mutex_lock
      0.32 =C2=B1  4%      -0.1        0.25 =C2=B1  4%  perf-profile.self.c=
ycles-pp.__update_load_avg_se
      0.39 =C2=B1  3%      -0.1        0.32 =C2=B1  6%  perf-profile.self.c=
ycles-pp.copy_user_generic_unrolled
      0.45 =C2=B1  3%      -0.1        0.38        perf-profile.self.cycles=
-pp._raw_spin_unlock_irqrestore
      0.19 =C2=B1  6%      -0.1        0.12 =C2=B1  8%  perf-profile.self.c=
ycles-pp.vfs_read
      0.34 =C2=B1  4%      -0.1        0.27 =C2=B1  2%  perf-profile.self.c=
ycles-pp.pick_next_entity
      0.84 =C2=B1  2%      -0.1        0.77        perf-profile.self.cycles=
-pp.enqueue_entity
      0.28 =C2=B1  5%      -0.1        0.21 =C2=B1  5%  perf-profile.self.c=
ycles-pp.syscall_return_via_sysret
      0.19 =C2=B1  4%      -0.1        0.12 =C2=B1 10%  perf-profile.self.c=
ycles-pp.__might_sleep
      0.35 =C2=B1  3%      -0.1        0.29        perf-profile.self.cycles=
-pp.__wake_up_common
      0.19 =C2=B1  4%      -0.1        0.12 =C2=B1  6%  perf-profile.self.c=
ycles-pp.___perf_sw_event
      0.47 =C2=B1  2%      -0.1        0.41 =C2=B1  2%  perf-profile.self.c=
ycles-pp.do_idle
      0.27 =C2=B1  4%      -0.1        0.21 =C2=B1  3%  perf-profile.self.c=
ycles-pp.__unwind_start
      0.22 =C2=B1  6%      -0.1        0.16 =C2=B1  2%  perf-profile.self.c=
ycles-pp.finish_task_switch
      0.34 =C2=B1  3%      -0.1        0.29        perf-profile.self.cycles=
-pp.schedule
      0.35 =C2=B1  6%      -0.1        0.29 =C2=B1  2%  perf-profile.self.c=
ycles-pp.update_cfs_group
      0.24 =C2=B1  6%      -0.1        0.19 =C2=B1  4%  perf-profile.self.c=
ycles-pp.orc_find
      0.21 =C2=B1  5%      -0.1        0.16 =C2=B1  7%  perf-profile.self.c=
ycles-pp.cpus_share_cache
      0.30 =C2=B1  7%      -0.1        0.25 =C2=B1  5%  perf-profile.self.c=
ycles-pp.nr_iowait_cpu
      0.18 =C2=B1  4%      -0.1        0.13        perf-profile.self.cycles=
-pp.resched_curr
      0.29 =C2=B1  3%      -0.1        0.24 =C2=B1  2%  perf-profile.self.c=
ycles-pp.mutex_unlock
      0.16 =C2=B1  9%      -0.1        0.11 =C2=B1  6%  perf-profile.self.c=
ycles-pp.place_entity
      0.32 =C2=B1  5%      -0.0        0.27        perf-profile.self.cycles=
-pp.cpuidle_enter_state
      0.23 =C2=B1  3%      -0.0        0.18 =C2=B1  3%  perf-profile.self.c=
ycles-pp._raw_spin_lock_irq
      0.22 =C2=B1  4%      -0.0        0.18 =C2=B1  4%  perf-profile.self.c=
ycles-pp.common_file_perm
      0.12 =C2=B1  3%      -0.0        0.08 =C2=B1 11%  perf-profile.self.c=
ycles-pp.in_sched_functions
      0.28 =C2=B1  3%      -0.0        0.24 =C2=B1  3%  perf-profile.self.c=
ycles-pp.native_sched_clock
      0.20 =C2=B1  4%      -0.0        0.15 =C2=B1  2%  perf-profile.self.c=
ycles-pp.__list_del_entry_valid
      0.12 =C2=B1  5%      -0.0        0.08 =C2=B1  6%  perf-profile.self.c=
ycles-pp.new_sync_write
      0.25            -0.0        0.21        perf-profile.self.cycles-pp._=
__might_sleep
      0.20 =C2=B1  4%      -0.0        0.16 =C2=B1  5%  perf-profile.self.c=
ycles-pp.vfs_write
      0.07 =C2=B1  7%      -0.0        0.03 =C2=B1100%  perf-profile.self.c=
ycles-pp.main
      0.29 =C2=B1  2%      -0.0        0.25 =C2=B1  4%  perf-profile.self.c=
ycles-pp.switch_mm_irqs_off
      0.21 =C2=B1  2%      -0.0        0.17 =C2=B1  4%  perf-profile.self.c=
ycles-pp.read_tsc
      0.07 =C2=B1  5%      -0.0        0.04 =C2=B1 58%  perf-profile.self.c=
ycles-pp.rcu_dynticks_eqs_exit
      0.12 =C2=B1  6%      -0.0        0.09 =C2=B1  7%  perf-profile.self.c=
ycles-pp.new_sync_read
      0.21 =C2=B1  2%      -0.0        0.18 =C2=B1  6%  perf-profile.self.c=
ycles-pp.entry_SYSCALL_64_after_hwframe
      0.12 =C2=B1  6%      -0.0        0.10 =C2=B1  9%  perf-profile.self.c=
ycles-pp.arch_stack_walk
      0.07 =C2=B1  6%      -0.0        0.04 =C2=B1 57%  perf-profile.self.c=
ycles-pp.update_min_vruntime
      0.11 =C2=B1  4%      -0.0        0.08 =C2=B1 10%  perf-profile.self.c=
ycles-pp.kernel_text_address
      0.23 =C2=B1  7%      -0.0        0.21 =C2=B1  5%  perf-profile.self.c=
ycles-pp.__account_scheduler_latency
      0.14 =C2=B1  6%      -0.0        0.11 =C2=B1 11%  perf-profile.self.c=
ycles-pp.__wrgsbase_inactive
      0.09 =C2=B1  9%      -0.0        0.06 =C2=B1  6%  perf-profile.self.c=
ycles-pp.__entry_text_start
      0.08 =C2=B1  5%      -0.0        0.05 =C2=B1  8%  perf-profile.self.c=
ycles-pp.copy_page_to_iter
      0.19 =C2=B1  6%      -0.0        0.17 =C2=B1  5%  perf-profile.self.c=
ycles-pp.pipe_write
      0.15 =C2=B1  3%      -0.0        0.13 =C2=B1  5%  perf-profile.self.c=
ycles-pp.__fget_light
      0.06 =C2=B1  6%      -0.0        0.04 =C2=B1 57%  perf-profile.self.c=
ycles-pp.unwind_get_return_address
      0.14 =C2=B1  7%      -0.0        0.12 =C2=B1  7%  perf-profile.self.c=
ycles-pp.switch_fpu_return
      0.09 =C2=B1  9%      -0.0        0.07 =C2=B1  7%  perf-profile.self.c=
ycles-pp.tick_nohz_next_event
      0.08 =C2=B1 11%      -0.0        0.05 =C2=B1  8%  perf-profile.self.c=
ycles-pp.__hrtimer_next_event_base
      0.16            -0.0        0.14 =C2=B1  6%  perf-profile.self.cycles=
-pp.pick_next_task_fair
      0.09 =C2=B1  9%      -0.0        0.07 =C2=B1  7%  perf-profile.self.c=
ycles-pp.__rdgsbase_inactive
      0.06            -0.0        0.04 =C2=B1 57%  perf-profile.self.cycles=
-pp.copy_page_from_iter
      0.14 =C2=B1  6%      -0.0        0.11 =C2=B1  7%  perf-profile.self.c=
ycles-pp.available_idle_cpu
      0.08 =C2=B1 16%      -0.0        0.06 =C2=B1  7%  perf-profile.self.c=
ycles-pp.call_cpuidle
      0.10 =C2=B1  8%      -0.0        0.08 =C2=B1  5%  perf-profile.self.c=
ycles-pp.syscall_exit_to_user_mode
      0.09 =C2=B1  5%      -0.0        0.07 =C2=B1  7%  perf-profile.self.c=
ycles-pp.rcu_idle_exit
      0.19 =C2=B1  3%      -0.0        0.17 =C2=B1  4%  perf-profile.self.c=
ycles-pp.dequeue_task_fair
      0.10 =C2=B1  4%      -0.0        0.08        perf-profile.self.cycles=
-pp.__calc_delta
      0.17 =C2=B1  2%      -0.0        0.16 =C2=B1  2%  perf-profile.self.c=
ycles-pp.anon_pipe_buf_release
      0.17 =C2=B1  4%      -0.0        0.15 =C2=B1  2%  perf-profile.self.c=
ycles-pp.copy_fpregs_to_fpstate
      0.06 =C2=B1  6%      -0.0        0.05        perf-profile.self.cycles=
-pp.copy_user_enhanced_fast_string
      0.06 =C2=B1  6%      -0.0        0.05        perf-profile.self.cycles=
-pp.put_task_stack
     36.91            +2.9       39.86        perf-profile.self.cycles-pp.i=
ntel_idle
     29.30 =C2=B1  2%      +3.9       33.15        perf-profile.self.cycles=
-pp.__cna_queued_spin_lock_slowpath


                                                                           =
    =20
                       unixbench.time.voluntary_context_switches           =
    =20
                                                                           =
    =20
  4.4e+08 +----------------------------------------------------------------=
-+  =20
          |                                                    +..  +..+. .=
.|  =20
  4.3e+08 |-+                                                  :   +     + =
 |  =20
  4.2e+08 |-+                                                 :   +        =
 |  =20
          |                                                   :            =
 |  =20
  4.1e+08 |-+                                                 :            =
 |  =20
    4e+08 |-+               +.            .+.. .+..+.+..+.   :             =
 |  =20
          |               ..  +..+.+..+.+.    +           +..+             =
 |  =20
  3.9e+08 |..+.+..+.+..+.+                                                 =
 |  =20
  3.8e+08 |-+                                                              =
 |  =20
          |                                                                =
 |  =20
  3.7e+08 |-+                      O    O  O    O  O                       =
 |  =20
  3.6e+08 |-+                         O       O      O  O O  O O  O O  O O =
 |  =20
          |  O      O  O O  O O                                            =
 |  =20
  3.5e+08 +----------------------------------------------------------------=
-+  =20
                                                                           =
    =20
                                                                           =
                                                                           =
         =20
                                  unixbench.score                          =
    =20
                                                                           =
    =20
  3800 +-------------------------------------------------------------------=
-+  =20
       |                                                              .+.  =
.|  =20
  3700 |-+                                                     +.  .+.   +.=
 |  =20
  3600 |-+                                                    :  +.        =
 |  =20
       |                                                      :            =
 |  =20
  3500 |-+                                                   :             =
 |  =20
  3400 |-+                                    .+.+..+..+.    :             =
 |  =20
       |                 .+.+..+..+.+..+..+.+.           +..+              =
 |  =20
  3300 |..+.+..+..+.+..+.                                                  =
 |  =20
  3200 |-+                                                                 =
 |  =20
       |                                                                   =
 |  =20
  3100 |-+                        O O  O  O O  O O  O  O    O  O O     O O =
 |  =20
  3000 |-+O         O  O    O                            O          O      =
 |  =20
       |    O  O  O       O    O                                           =
 |  =20
  2900 +-------------------------------------------------------------------=
-+  =20
                                                                           =
    =20
                                                                           =
                                                                           =
         =20
                                  unixbench.workload                       =
    =20
                                                                           =
    =20
    6e+08 +----------------------------------------------------------------=
-+  =20
          |                                                                =
 |  =20
  5.8e+08 |-+                                                  +..  +..+. .=
.|  =20
          |                                                    :   +     + =
 |  =20
  5.6e+08 |-+                                                 :   +        =
 |  =20
          |                                                   :            =
 |  =20
  5.4e+08 |-+                                                 :            =
 |  =20
          |                .+.    .+..    .+..+.+..+.+..+.   :             =
 |  =20
  5.2e+08 |.. .+..    .+.+.   +..+    +.+.                +..+             =
 |  =20
          |  +    +.+.                                                     =
 |  =20
    5e+08 |-+                                                              =
 |  =20
          |                        O    O  O    O  O                       =
 |  =20
  4.8e+08 |-+                         O       O      O  O O  O O  O O  O O =
 |  =20
          |  O O    O  O O  O O  O                                         =
 |  =20
  4.6e+08 +----------------------------------------------------------------=
-+  =20
                                                                           =
    =20
                                                                           =
    =20
[*] bisect-good sample
[O] bisect-bad  sample



Disclaimer:
Results have been estimated based on internal Intel analysis and are provid=
ed
for informational purposes only. Any difference in system hardware or softw=
are
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--__1606330561723405157abhmp0020.oracle.com
Content-Type: text/x-patch; charset=UTF-8;
 name="0006-locking-qspinlock-Introduce-the-shuffle-reduction-op.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0006-locking-qspinlock-Introduce-the-shuffle-reduction-op.patch"

From 7da41e2aab3b53579a762767314ac54a469eb52f Mon Sep 17 00:00:00 2001
From: Alex Kogan <alex.kogan@oracle.com>
Date: Wed, 25 Nov 2020 13:51:08 -0500
Subject: [PATCH v12 6/6] locking/qspinlock: Introduce the shuffle reduction
 optimization into CNA

This performance optimization chooses probabilistically to avoid moving
threads from the main queue into the secondary one when the secondary queue
is empty.

It is helpful when the lock is only lightly contended. In particular, it
makes CNA less eager to create a secondary queue, but does not introduce
any extra delays for threads waiting in that queue once it is created.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 39 ++++++++++++++++++++++++++++++++++++++=
-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.=
h
index ac3109a..6213992 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -5,6 +5,7 @@
=20
 #include <linux/topology.h>
 #include <linux/sched/rt.h>
+#include <linux/random.h>
=20
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware l=
ock).
@@ -86,6 +87,34 @@ static inline bool intra_node_threshold_reached(struct c=
na_node *cn)
 =09return current_time - threshold > 0;
 }
=20
+/*
+ * Controls the probability for enabling the ordering of the main queue
+ * when the secondary queue is empty. The chosen value reduces the amount
+ * of unnecessary shuffling of threads between the two waiting queues
+ * when the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  (7)
+
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Return false with probability 1 / 2^@num_bits.
+ * Intuitively, the larger @num_bits the less likely false is to be return=
ed.
+ * @num_bits must be a number between 0 and 31.
+ */
+static bool probably(unsigned int num_bits)
+{
+=09u32 s;
+
+=09s =3D this_cpu_read(seed);
+=09s =3D next_pseudo_random32(s);
+=09this_cpu_write(seed, s);
+
+=09return s & ((1 << num_bits) - 1);
+}
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 =09struct mcs_spinlock *base =3D per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -290,7 +319,15 @@ static __always_inline u32 cna_wait_head_or_lock(struc=
t qspinlock *lock,
 {
 =09struct cna_node *cn =3D (struct cna_node *)node;
=20
-=09if (!cn->start_time || !intra_node_threshold_reached(cn)) {
+=09if (node->locked <=3D 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) {
+=09=09/*
+=09=09 * When the secondary queue is empty, skip the call to
+=09=09 * cna_order_queue() with high probability. This optimization
+=09=09 * reduces the overhead of unnecessary shuffling of threads
+=09=09 * between waiting queues when the lock is only lightly contended.
+=09=09 */
+=09=09cn->partial_order =3D LOCAL_WAITER_FOUND;
+=09} else if (!cn->start_time || !intra_node_threshold_reached(cn)) {
 =09=09/*
 =09=09 * We are at the head of the wait queue, no need to use
 =09=09 * the fake NUMA node ID.
--=20
2.7.4


--__1606330561723405157abhmp0020.oracle.com--
