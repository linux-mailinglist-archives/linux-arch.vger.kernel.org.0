Return-Path: <linux-arch+bounces-244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3C27F005A
	for <lists+linux-arch@lfdr.de>; Sat, 18 Nov 2023 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93231C20748
	for <lists+linux-arch@lfdr.de>; Sat, 18 Nov 2023 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A200112E4D;
	Sat, 18 Nov 2023 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PPS36QHm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2108.outbound.protection.outlook.com [40.107.94.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8250A126;
	Sat, 18 Nov 2023 07:47:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag3Ojf+4gKe3YhohMwQ1nYrjHMPFAuiHmLXjga8qEjEwAV65oVR7Haa/O69tom593RO1YSfTPJBf/o+PqRgrT6CRoIQhXwC2H9YtyLrURealxVD1I2MfaldFtEnj5g0ycXttIe0cBStX9OqloE7ahVUtYo/Ww2rkF8V697bEwx3C8rtzD1k3z6LtUcePsBAK5NW+DqDV5ToWzxmWwJS7iv4LXYi8PdL3m3owAsbHse/sYjWbDzDO4RTdfXis2ccQgp5bGsStUL55UHHsvyXbqBzOTq7CKETmHasCuUsW5S/tlyFYbPectFun5+ji0zkZ05MqSZYZ0CbJWQDkqawchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OamWYxVHYSl/8BSwA7S6GjnkHHLCbgyMzNHUNUPpZqU=;
 b=ZNYZ+s3CREpFB7xitKW7gsxpmSMiR/MMYm9ctz+3kq0r8+R/jEWgNEPiUPeKt84WOFhPWY/CG5j0322IlP/IwMJjCQVvfgwx9mxJCaeR4tsEsrnWvejrA3QAe5qn3mSNC5Em/uobimUvrUua4nlt8kSZ/0kaTIwd4s/xQ5fGqUYxy/1beGCIqvQ4OLDbMlYYj7oIaCIvwcFza185HsBhv+AX7+/BjaYtKQ+BEr8hQr75NJPjFU57oYB7qJf6U4V/Z+Fp9QIm1zVq8BzjlhV/um8DtplpTKDj5IlepMgU/fsguFJxA9yfrqb71320L8x0YxB38aottRMaharvr9mviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OamWYxVHYSl/8BSwA7S6GjnkHHLCbgyMzNHUNUPpZqU=;
 b=PPS36QHm+hWNUzMfUdg5u6FtvkuNfZBzQlbl3h4bHR1b+6wpzWoGGbEa44tXeiMRp1o0nTNLCAnM5ZQ4apdYHWn28FOTpbj1xXZHflnhsACXw3/FRWn1BBKooUgoeQOijKPDnr+KXLt2M5nQ0Plw0JfJySUagYep7ce/6UhddAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MW4PR01MB6259.prod.exchangelabs.com (2603:10b6:303:78::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.23; Sat, 18 Nov 2023 15:47:46 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.6977.028; Sat, 18 Nov 2023
 15:47:45 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com
Cc: will@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	arnd@arndb.de,
	mark.rutland@arm.com,
	broonie@kernel.org,
	keescook@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	patches@amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2] arm64: irq: set the correct node for VMAP stack
Date: Sat, 18 Nov 2023 23:47:07 +0800
Message-Id: <20231118154707.3668-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZVZO55IjQSbzWnfG@arm.com>
References: <ZVZO55IjQSbzWnfG@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::9) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MW4PR01MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 802dc9b1-52df-46f8-40d1-08dbe84db52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oaWslfWNQ1KEI79pC/GVu9XJ0Xq9k9rlRwhfqXWXntd8SzBQfXzYDfhR7iWtZ08W8kRTcj2WiUjl1zlhf4TTvFnBncr64ijN9J7PkQ5c96IosnjJuVnXnMS9bADpPf3IneYx2gFp364YuBt4+YU+CpbMae+Id5F3vu/p6pDSpk+xtEZSeTYPOfbqC3efN+XpE9LhktAHHxJ0e2xZUfWgz+efxTqMXPhqXfa/ICT5ihVBxCHdHw5S4RXJy05fPK7rqKQSNZmDJFS871Kgc+ceJoszIlpMnszOQkSXDY8cJFuVHwZen6e9qmi+h/mNYkGwnrEs7/rqEbRopaGXx5LmoGZQ9ktp8JfHuqCWKRm7l3GabKmELQqjEZ9qkTF0rSWGsBOFG4tG6kl4KmnbCW+PDhnCWjKy+WWewZzoP3Sud7CVxQ+qdre80Y+tgGLeQleCRPG1YvI9UJBZXbkaG/Ih1JvvODCXF3QMKMZxmikzHYinkZf+oWJvF3sIEQPG5ixUvVnP1COFyhhz4sk4OP7YqZ+0w5Ir9ah8ZEqQvZSAxk9AuVE7ba98MemsBHTIHutF7VbzwEqjmDMt+er+z1wAPe9dPx4kap6SUEzGEzS+ioZFztTndUbO7uV631CdfPbW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(316002)(6916009)(26005)(1076003)(66556008)(66476007)(66946007)(86362001)(8936002)(38350700005)(4326008)(38100700002)(8676002)(41300700001)(2906002)(5660300002)(7416002)(6486002)(83380400001)(6506007)(52116002)(478600001)(6512007)(107886003)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t2xv7hdzCfBc/6jO2RVgVSUIRvUr6pG7VGZtgdWIMdhLfZJ/NY9Wq8LYVgNy?=
 =?us-ascii?Q?XFRHfOBfkIv3zqXb+BzizmTOOKc+wjfvrChtvl2emmvblxFRgCg+vkuQ6epn?=
 =?us-ascii?Q?FPQoKbyBXN2LI+7Y2Fe2DEeqP5Z/FU3ANYX5Mw6Byd7JYpblqIOdGmvlD/UJ?=
 =?us-ascii?Q?pAVps3V0JnDBXA3AVSp6jfE48Isx+4OsmSzJfBbGH6q4kJ4VY6/0EwDEgHjT?=
 =?us-ascii?Q?95g+WVTGcwDNx4gIvav86WrUfdq65bc8fIbin6rycyjnRte3cfcGxCxGrMj/?=
 =?us-ascii?Q?hlNHJT//9RWULGCyH1gpF002+BlvH6iw1jSDBRu3frjD8tTK7XlslDUPIg5A?=
 =?us-ascii?Q?83LjgtjFQzMHIc3R5W3EFRehhdiA8/9zwCRJ4QtDyn6R3PJDBKFynY4NdrlE?=
 =?us-ascii?Q?LQ9B1ADs7DxGoKUZOLqGQU+vLBSpVGnC8QZkZMIWu7uWGlJ6DpHuX3PT49ja?=
 =?us-ascii?Q?5xUNtZ3GA1cF/xGNxNO0NTeN8ThMoQhFw1qcnj1zTzOB9WVLoWYTGema31ds?=
 =?us-ascii?Q?Wbso6b2WghM51lo6/IB7pZM6CCPAT07AM/xSgagJN/b9CYcFPT8pxIWtbSsE?=
 =?us-ascii?Q?Ip6VmEBOsKpYf1avAb/Pir66DS3uS2du63VfLYYghplXs9QCPsFKWPGQT9Q7?=
 =?us-ascii?Q?ySZ0CJZRclOLLMhyg36q1MQ1kA2FQ1QhNaFLhF7XesvSCr7+5XJOuRjyyMNS?=
 =?us-ascii?Q?BTn+daVFTrvUvrpbVsKI6uYzGBwIGgKZ8kjyDVi7qDiloPI5Tx97w5iDLUGl?=
 =?us-ascii?Q?+PoudgTNPSipgPMkkuoDoYYjUt2fPq8CzfAU+GebYOMOi2o/a0alRmvO6IWT?=
 =?us-ascii?Q?gZQdbj8oIT/TX/OVzOPJ2NRYJ+92IqQoGsnFEYpaH9eC5jvoNgRld0wqWW1Q?=
 =?us-ascii?Q?Fu1rEd5mprKoBbwV8jWPd67kAU2b6bibvdZi9SxGvTD4tttFCH/35Tc0D/kL?=
 =?us-ascii?Q?NqnB2gZdsIMvLsEL93VS+ozp32msiRMmCNZ083BNccv1BkeuW2cEfvxlwh5Q?=
 =?us-ascii?Q?UCkIKBVr1HmPdp7XWWQbSht+YSmvMFPD0Z1mRHhRWYGIPDt6OokadhUm8bio?=
 =?us-ascii?Q?Em+aULtV2lUYrJI0gJKFZ24wiM2qPNoN3lcXkm+FFrv80tj+3wVSF1AoceM6?=
 =?us-ascii?Q?AozqASe0exGKxXMn8rqcl009MnjUv+9f26rAv09SnDieglE0UpIumYSWys46?=
 =?us-ascii?Q?4A/Mr+XsOcNz8oE0uEh0S8O6LyDEW/0m5NDyZz7vRCul8kAb93lxnqah55Ic?=
 =?us-ascii?Q?M+CHZvPsywv6qtJ36ax7AN4303DDnT4qkz1dZD1Kq3onM0pKSvIBup85eeH5?=
 =?us-ascii?Q?vp9prFH7Kcegbk8DFOlUwX3c/jGHkf+9WSPlRUj3xTksy0GUSSgorovC7Sor?=
 =?us-ascii?Q?W0BOhOZL9fK9GAoiFJ1PTvz4e55frv/qCSOlz6R/xVGKcWdbFW7+gRUQb0sX?=
 =?us-ascii?Q?dEKOfsO9a7Z/MgtgLgiVWrqUcQTSzGvWy7GHTnDNIu8gmW2mF/5LyLS7wAcQ?=
 =?us-ascii?Q?6KqEeKhQHFq+rmnHl1Gl+iKDVhDQivGzV53OFV5h8JPOgkedx52qbWdLt7A4?=
 =?us-ascii?Q?89gVe4CiQinLC83H2HDm3e26hk4zyzDhDKPeM8C70FegQS/6Zg3kLcaYfsXi?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802dc9b1-52df-46f8-40d1-08dbe84db52e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 15:47:45.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gTgczTAw3VdkPQgyqJq9wPdkVBB/NJlJ2QzGo/P9BPoJgBs4bR3Wg1LN0T0XKjpIQn12B1lqQq9dF1Sj1lQPxaYpKvW9pDQYQqQVoGZ00+QyYFA9iRr/DKUkOt4JM9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6259

In current code, init_irq_stacks() will call cpu_to_node().
The cpu_to_node() depends on percpu "numa_node" which is initialized in:
     arch_call_rest_init() --> rest_init() -- kernel_init()
	--> kernel_init_freeable() --> smp_prepare_cpus()

But init_irq_stacks() is called in init_IRQ() which is before
arch_call_rest_init().

So in init_irq_stacks(), the cpu_to_node() does not work, it
always return 0. In NUMA, it makes the node 1 cpu accesses the IRQ stack which
is in the node 0.

This patch fixes it by exporting the early_cpu_to_node(), and use it
in the init_irq_stacks().

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2:
	fix the !NUMA compiling error.

---
 arch/arm64/kernel/irq.c    | 3 ++-
 drivers/base/arch_numa.c   | 2 +-
 include/asm-generic/numa.h | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 6ad5c6ef5329..5226030979ae 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -25,6 +25,7 @@
 #include <asm/softirq_stack.h>
 #include <asm/stacktrace.h>
 #include <asm/vmap_stack.h>
+#include <asm/numa.h>
 
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
@@ -57,7 +58,7 @@ static void init_irq_stacks(void)
 	unsigned long *p;
 
 	for_each_possible_cpu(cpu) {
-		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
+		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
 		per_cpu(irq_stack_ptr, cpu) = p;
 	}
 }
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index eaa31e567d1e..90519d981471 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-static int __init early_cpu_to_node(int cpu)
+int early_cpu_to_node(int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index 1a3ad6d29833..16073111bffc 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -35,6 +35,7 @@ int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
+int early_cpu_to_node(int cpu);
 void numa_store_cpu_info(unsigned int cpu);
 void numa_add_cpu(unsigned int cpu);
 void numa_remove_cpu(unsigned int cpu);
@@ -46,6 +47,7 @@ static inline void numa_add_cpu(unsigned int cpu) { }
 static inline void numa_remove_cpu(unsigned int cpu) { }
 static inline void arch_numa_init(void) { }
 static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
+static inline int early_cpu_to_node(int cpu) { return 0; }
 
 #endif	/* CONFIG_NUMA */
 
-- 
2.40.1


